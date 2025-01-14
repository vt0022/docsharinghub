package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Role;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.VerificationCode;
import com.advanced_mobile_programing.docs_sharing.jwt.JWTService;
import com.advanced_mobile_programing.docs_sharing.model.AuthModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.LoginRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.SignupRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.UserResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IRoleService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
import com.advanced_mobile_programing.docs_sharing.service.IVerificationCodeService;
import com.advanced_mobile_programing.docs_sharing.util.EmailService;
import com.advanced_mobile_programing.docs_sharing.util.PasswordCheck;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.*;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {
    private final ModelMapper modelMapper;
    private final IUserService userService;
    private final IRoleService roleService;
    private final EmailService emailService;
    private final IVerificationCodeService verificationCodeService;
    private final AuthenticationManager authenticationManager;
    private final JWTService jwtService;

    @Value("${API_KEY}")
    private String SECRET_KEY;

    @Autowired
    public AuthController(ModelMapper modelMapper, IUserService userService, IRoleService roleService, EmailService emailService, IVerificationCodeService verificationCodeService, AuthenticationManager authenticationManager, JWTService jwtService) {
        this.modelMapper = modelMapper;
        this.userService = userService;
        this.roleService = roleService;
        this.emailService = emailService;
        this.verificationCodeService = verificationCodeService;
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@Valid @RequestBody SignupRequestModel signupRequest) {

        Optional<User> user = userService.findByEmail(signupRequest.getEmail());

        if (user.isPresent()) {
            if (user.get().isAuthenticated())
                throw new RuntimeException("Email already registered");
            else
                throw new RuntimeException("Account needs activated");
        }

        if (!signupRequest.getPassword().equals(signupRequest.getConfirmPassword())) {
            throw new RuntimeException("Passwords not match");
        }

        if (!new PasswordCheck().validatePassword(signupRequest.getPassword())) {
            throw new RuntimeException("Invalid password format");
//            Ít nhất một chữ số
//            Ít nhất một chữ thường
//            Ít nhất một chữ hoa
//            Ít nhất một ký tự đặc biệt
//            Không có khoảng trắng
//            Ít nhất 8 ký tự
        }

        // Role
        Role role = roleService.findById(3).orElseThrow(() -> new RuntimeException("Role not found"));
        User newUser = modelMapper.map(signupRequest, User.class);
        newUser.setRole(role);
        newUser = userService.save(newUser);

        UserResponseModel userResponseModel = modelMapper.map(newUser, UserResponseModel.class);
        ResponseModel signupResponse = new ResponseModel().builder()
                .status(200)
                .error(false)
                .message("Sign up successfully. Please verify first.")
                .data(userResponseModel)
                .build();
        return ResponseEntity.ok(signupResponse);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequestModel loginRequestModel) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginRequestModel.getEmail(), loginRequestModel.getPassword()));
        } catch (Exception e) {
            Optional<User> optionalUser = userService.findByEmail(loginRequestModel.getEmail());
            if (!optionalUser.isPresent())
                throw new BadCredentialsException("Email not registered");
            else
                throw new BadCredentialsException("Wrong password");
        }

        Optional<User> user = userService.findByEmail(loginRequestModel.getEmail());
        if (user.get().isDisabled())
            throw new RuntimeException("Account disabled");
        else if (!user.get().isAuthenticated())
            throw new RuntimeException("Account needs activated");

        Role role = user.get().getRole();

        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(role.getRoleName()));
        // Generate JWT
        var jwtToken = jwtService.generateToken(user.get(), authorities);
        var jwtRefreshToken = jwtService.generateRefreshToken(user.get());

        // Get profile
        UserResponseModel userResponseModel = modelMapper.map(user, UserResponseModel.class);

        AuthModel authResponse = AuthModel.builder()
                .accessToken(jwtToken)
                .refreshToken(jwtRefreshToken)
                .user(userResponseModel)
                .build();

        return ResponseEntity.ok().body(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Login successfully")
                .data(authResponse)
                .build());
    }

    @Operation(summary = "Send email with OTP")
    @PostMapping("/sendEmail")
    public ResponseEntity<?> sendResetPasswordEmail(@RequestParam String email,
                                                    @RequestParam(defaultValue = "reset") String type) {
        User user = userService.findByEmail(email).orElseThrow(() -> new RuntimeException("Email not registered"));

        Random random = new Random();
        int code = random.nextInt(900000) + 100000;

        VerificationCode verificationCode = new VerificationCode();
        Optional<VerificationCode> verificationCodeOptional = verificationCodeService.findByUser(user);
        if (verificationCodeOptional.isPresent()) {
            verificationCode = verificationCodeOptional.get();
            verificationCode.setCode(code);
        } else {
            verificationCode.setCode(code);
            verificationCode.setUser(user);
        }
        verificationCode.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        verificationCode.setExpiredAt(new Timestamp(System.currentTimeMillis() + 15 * 60 * 1000));
        verificationCode.setExpired(false);
        verificationCodeService.save(verificationCode);

        if (type.equals("reset"))
            emailService.sendEmail(
                    email,
                    "RESET PASSWORD",
                    code,
                    "reset_password_email");
        else // register
            emailService.sendEmail(
                    email,
                    "VERIFY ON REGISTER",
                    code,
                    "verify_on_signup_email");

        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Send code successfully")
                .build());
    }

    @Operation(summary = "Verify OTP from email")
    @PostMapping("/verify")
    public ResponseEntity<?> verifyUser(@RequestParam String email,
                                        @RequestParam int code,
                                        @RequestParam(defaultValue = "reset") String type) {
        User user = userService.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));

        VerificationCode verificationCode = verificationCodeService.findByUser(user).orElseThrow(() -> new RuntimeException("Invalid verification code"));

        if (verificationCode.getCode() == code) {
            if (verificationCode.isExpired())
                throw new RuntimeException("Verification code is expired");
            else {
                if (verificationCode.getExpiredAt().getTime() > System.currentTimeMillis()) {
                    verificationCode.setExpired(true);
                    verificationCodeService.save(verificationCode);

                    if (type.equals("register")) {
                        user.setAuthenticated(true);
                        userService.update(user);
                    }
                    return ResponseEntity.ok(ResponseModel.builder()
                            .status(200)
                            .error(false)
                            .message("Verify user successfully on " + (type.equals("reset") ? "resetting" : "registering"))
                            .build());
                } else throw new RuntimeException("Verification code is expired");

            }
        } else throw new RuntimeException("Wrong verification code");

    }

    @PostMapping("/refresh")
    public ResponseEntity<?> refresh(@Valid @RequestBody Map<String, String> refreshToken) {
        Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY.getBytes());
        JWTVerifier verifier = JWT.require(algorithm).build();
        DecodedJWT decodedJWT = verifier.verify(refreshToken.get("refreshToken"));
        String username = decodedJWT.getSubject().split(" ")[0]; // Get email

        User user = userService.findByEmail(username).orElseThrow(() -> new UsernameNotFoundException("Email not registered"));

        Role role = user.getRole();

        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(role.getRoleName()));

        String accessToken = jwtService.generateToken(user, authorities);

        // Get profile
        UserResponseModel userResponseModel = modelMapper.map(user, UserResponseModel.class);

        AuthModel authResponse = AuthModel.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken.get("refreshToken"))
                .user(userResponseModel)
                .build();


        ResponseModel refreshResponse = new ResponseModel().builder()
                .status(200)
                .error(false)
                .message("Renew access token successfully")
                .data(authResponse)
                .build();
        return ResponseEntity.ok(refreshResponse);

    }
}
