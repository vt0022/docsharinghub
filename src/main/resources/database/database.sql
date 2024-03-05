create database if not exists docs_sharing

create table role
(
    id        binary(16)   not null
        primary key,
    role_name varchar(255) not null,
    constraint UK_iubw515ff0ugtm28p8g3myt0h
        unique (role_name)
);

create table user
(
    user_id       binary(16)   not null
        primary key,
    created_at    datetime(6)  null,
    date_of_birth datetime(6)  null,
    email         varchar(50)  not null,
    first_name    varchar(50)  null,
    gender        int          not null,
    image         varchar(255) null,
    is_disabled   bit          not null,
    last_name     varchar(50)  null,
    password      varchar(255) not null,
    updated_at    datetime(6)  null,
    role_id       binary(16)   null,
    constraint UK_ob8kqyqqgmefl0aco34akdtpe
        unique (email),
    constraint FK9usot4gododq1u90duvulb92d
        foreign key (role_id) references role (id)
);

create table verification_code
(
    id         binary(16)  not null
        primary key,
    code       int         null,
    created_at datetime(6) null,
    expired_at datetime(6) null,
    is_expired bit         not null,
    user_id    binary(16)  null,
    constraint UK_n576esytmxxfkgon3ja83h5vp
        unique (user_id),
    constraint FKp1pqkmx3v807phru4u2px3okc
        foreign key (user_id) references user (user_id)
);

insert into docs_sharing.role (id, role_name)
values (0xC0A801B98AC01A60818AC04A8FB50038, 'ROLE_ADMIN'),
       (0xC0A801B98AC01A60818AC04A8FA60037, 'ROLE_MANAGER'),
       (0xC0A801B98AC01A60818AC04A8F950035, 'ROLE_STUDENT');

insert into docs_sharing.user (user_id, created_at, date_of_birth, email, first_name, gender, image, is_disabled,
                               last_name, password, updated_at, role_id)
values (0xAC1C20018C5D19A7818C5EF63A840122, '2023-12-12 23:57:24.356000', '1995-02-12 00:00:00.000000',
        'thanhminh1203@gmail.com', 'Thành Minh', 0, null, false, 'Lê',
        '$2a$10$THPrBzBUMyI2ospNwy4nleGkuG3CiDNpVbrN8Tdq8jylXvnGWouhi', '2023-12-13 12:33:29.004000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xAC1C20018C5D19A7818C5EF63B1F0123, '2023-12-12 23:57:24.511000', '1992-06-05 00:00:00.000000',
        'anhtu0506@gmail.com', 'Anh Tú', 0, null, false, 'Văn',
        '$2a$10$BGBoIoU5gCBdBTNU62prQOoA.vGqwXljwqnaaOeNrzc2ZecFxaI1m', '2023-12-13 12:33:29.157000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xAC1C20018C5D19A7818C5EF63BE70124, '2023-12-12 23:57:24.711000', '1997-11-17 00:00:00.000000',
        'ngocngan1711@gmail.com', 'Ngọc Ngân', 1, null, false, 'Trần Lê',
        '$2a$10$GD8/tJEJLXktd61ew0ynl.5dJASdzCPQ8gknAHfyV8L1W3yLZ38dK', '2023-12-13 12:33:29.296000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xAC1C20018C5D19A7818C5EF63C8B0125, '2023-12-12 23:57:24.875000', '1995-10-12 00:00:00.000000',
        'ynhi1210@gmail.com', 'Ý Nhi', 1, null, false, 'Phan',
        '$2a$10$9zN5kHVfuTSJl5YHLRlsGOQdtVVMtEfzauc4f3WOI4omqQwK.4cDW', '2023-12-13 12:33:29.513000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xAC1C20018C5D19A7818C5EF63D250126, '2023-12-12 23:57:25.029000', '1995-06-04 00:00:00.000000',
        'minhdang0406@gmail.com', 'Minh Đăng', 0, null, false, 'Lê',
        '$2a$10$HCTocTLPk7CQZvFwcSK.ke7Cs5752Y4szajZrfJ7k997cY7Q9MhTe', '2023-12-13 12:33:29.801000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF63DBF0127, '2023-12-12 23:57:25.183000', '1980-01-01 00:00:00.000000',
        'hoangphuc0101@gmail.com', 'Hoàng Phúc', 0, null, false, 'Phạm',
        '$2a$10$.NkgGr1CcEPyzGn9yV7po.nXebChdMlwwuTmz6CUZmO9tschaeDMK', '2023-12-13 12:33:30.058000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF63E6D0128, '2023-12-12 23:57:25.357000', '2005-05-19 00:00:00.000000',
        'vantu1905@gmail.com', 'Văn Tú', 0, null, false, 'Hoàng',
        '$2a$10$2YC/iiWlVKi./BhUxCCCfehA5PUUqfB0MsrBUH/eTElxZ.Zw8i8Ue', '2023-12-13 12:33:30.212000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF63F190129, '2023-12-12 23:57:25.529000', '1994-05-12 00:00:00.000000',
        'thienthanh1205@gmail.com', 'Thiên Thành', 0, null, false, 'Vũ',
        '$2a$10$oJWggU3G3PIPN7KDOiQNPuedLH1667jhrMXPjVyiSTjzFOYS6BSNK', '2023-12-13 12:33:30.363000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF63FE9012A, '2023-12-12 23:57:25.737000', '1990-08-26 00:00:00.000000',
        'ngochan2608@gmail.com', 'Ngọc Hân', 1, null, false, 'Ngô',
        '$2a$10$1rVp/LDy25LMV20a4mYPRe/PnbbhhgUkeKVuw274iHHHlkzQZs6Uu', '2023-12-13 12:33:30.510000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF6407D012B, '2023-12-12 23:57:25.885000', '2001-02-17 00:00:00.000000',
        'thikieu1703@gmail.com', 'Thị Kiều', 1, null, false, 'Đinh',
        '$2a$10$Mdv3Vibgsvmc7qRhQMktA.zZOt.SFVvfbJ96Hr1d/pvQkaaP37q9y', '2023-12-13 12:33:30.649000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF64112012C, '2023-12-12 23:57:26.034000', '1990-11-30 00:00:00.000000',
        'tantho3011@gmail.com', 'Tấn Thọ', 0, null, false, 'Lý',
        '$2a$10$F5KLexFwvCACB7lTlxoSyejpj3LYu6vxhbNPI8eqH3J2QdBvuAi4e', '2023-12-13 12:33:30.788000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF641A8012D, '2023-12-12 23:57:26.184000', '1986-08-08 00:00:00.000000',
        'ngocphuc0808@gmail.com', 'Ngọc Phúc', 0, null, false, 'Phan',
        '$2a$10$2Y2Y.FsH354WlAU7bbZE5OLbAICQO.La28LqFuzlYsBYdfGQH3aES', '2023-12-13 12:33:30.920000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF64287012E, '2023-12-12 23:57:26.407000', '2002-01-19 00:00:00.000000',
        'thinga1901@gmail.com', 'Thị Nga', 1, null, false, 'Nguyễn',
        '$2a$10$7COMF9a5RxlW9Eo0vlSxluiAH.CCk6nCilRrWHWU7suiYkq4xyE.S', '2023-12-13 12:33:31.065000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF6430E012F, '2023-12-12 23:57:26.542000', '1992-07-17 00:00:00.000000',
        'duyphuc1707@gmail.com', 'Duy Phúc', 0, null, false, 'Đặng',
        '$2a$10$wrVvWK1/orWr4sl12O2JDe/NzXG3hQ0E8zHI0AOH3Such6XsAFVLC', '2023-12-13 12:33:31.201000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF6439A0130, '2023-12-12 23:57:26.682000', '1988-05-10 00:00:00.000000',
        'tanhai1005@gmail.com', 'Tấn Hải', 0, null, false, 'Nguyễn',
        '$2a$10$4bn.y/d6EUy4pgrvoCaINOpZ5Vdgk9.fc5s/XR.yGiSqfqOeUJLc.', '2023-12-13 12:33:31.334000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF6441E0131, '2023-12-12 23:57:26.814000', '1999-02-16 00:00:00.000000',
        'phucan1602@gmail.com', 'Phúc An', 0, null, false, 'Trần',
        '$2a$10$o5kqinB37PAuPaYCbCtO5.GXYfHU1OmF/zaAmtsnqf5/fGyCR4KO6', '2023-12-13 12:33:31.469000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF6453E0132, '2023-12-12 23:57:27.102000', '1993-02-20 00:00:00.000000',
        'vananh2002@gmail.com', 'Văn Anh', 0, null, false, 'Phạm',
        '$2a$10$1QwKJDu8ZNvAO.I.sObx2u33MXNsUNTz4G9q16dGB7MR9TRxDPVTe', '2023-12-13 12:33:31.603000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF645E40133, '2023-12-12 23:57:27.268000', '2004-09-17 00:00:00.000000',
        'tranminh1709@gmail.com', 'Trần Minh', 0, null, false, 'Lê',
        '$2a$10$WQgBf0W319EZW8Z.Dt/tMul/kFapXEbD0qJc51km8eyCKjgPhW7ZC', '2023-12-13 12:33:31.738000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF6476D0134, '2023-12-12 23:57:27.661000', '1997-04-27 00:00:00.000000',
        'ngocduyen2704@gmail.com', 'Ngọc Duyên', 1, null, false, 'Lê',
        '$2a$10$qnnqEoWbRnZ9SIbzYBwB2OtrYZmqrXr2OT1OROHwxs6ajalsZVWXS', '2023-12-13 12:33:31.874000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF648990135, '2023-12-12 23:57:27.961000', '1997-01-14 00:00:00.000000',
        'minhanh1401@gmail.com', 'Minh Anh', 0, null, false, 'Trần',
        '$2a$10$XogLg36S4eF9Ca4ZkVxDkupOdUqvpahfNHlk/t.tFDMOEUHZwPNe2', '2023-12-13 12:33:32.013000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF6498D0136, '2023-12-12 23:57:28.205000', '2003-08-30 00:00:00.000000',
        'tuantu3008@gmail.com', 'Tuấn Tú', 0, null, false, 'Phan',
        '$2a$10$UtOXLuZO0cKWQaK4mWjNEebI1vB.S6.vdbXwPwFp5y.A5EwrwaVj2', '2023-12-13 12:33:32.149000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xAC1C20018C5D19A7818C5EF64A3A0137, '2023-12-12 23:57:28.378000', '1992-05-05 00:00:00.000000',
        'quoctuan0505@gmail.com', 'Quốc Tuấn', 0, null, false, 'Nguyễn',
        '$2a$10$CAVgg8rYqz5mRPkDCKYV9u2GnxT/sTE1EqDNx.egaXbo/5imHP41C', '2023-12-13 12:33:32.291000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xAC1C20018C5D19A7818C5EF64AD10138, '2023-12-12 23:57:28.529000', '2001-09-10 00:00:00.000000',
        'tutrinh1009@gmail.com', 'Tú Trình', 0, null, false, 'Võ Lê',
        '$2a$10$7LeISovxlvwHrGFnijx4oOjxVNIAbCTPqjNZcK15GSjYJnOm89NAy', '2023-12-13 12:33:32.423000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B78AEC11BD818AEC01E10D0000, '2023-10-01 23:11:00.749000', '2002-11-10 00:00:00.000000',
        'lephananh16@gmail.com', 'Anh', 1, null, false, 'Lê',
        '$2a$10$d.3D4QSnCj4se3hMlu.Vn.XeGRdoxq3Sin4PCpUoCkGIfTfHRq5Ze', '2023-10-01 23:11:00.749000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xC0A801B78B901484818B90BCF2660001, '2023-12-02 22:53:03.846000', '1990-10-09 00:00:00.000000',
        'thuannguyen1012@gmail.com', 'Thuận', 0, 'https://drive.google.com/uc?id=194PCQEYVau6TMi79H0EJR9YAimsx1gBc',
        false, 'Nguyễn Văn', '$2a$10$oLwgKKJyDl33GMeuSuddF.bEui/A7XU5kfAmEmogmI4qTvzVvpL5K',
        '2023-12-14 01:39:35.978000', 0xC0A801B98AC01A60818AC04A8FA60037),
       (0xC0A801B88C661A7E818C66A987C90000, '2023-12-14 11:50:35.593000', '2002-06-11 00:00:00.000000',
        '20110732@student.hcmute.edu.vn', 'Van Thuan', 0,
        'https://drive.google.com/uc?id=1S2_YwA8uzZTHWubzptbrCtd9OAXYLiv-', false, 'Nguyen',
        '$2a$10$R5aq9soSvR8ID7nXNtXUQ.lx/qPZ1uwIyzV8XrLahoqDp29Qxtrfm', '2023-12-14 11:50:35.593000',
        0xC0A801B98AC01A60818AC04A8FB50038),
       (0xC0A801B98AC51120818AC531335B0000, '2023-09-24 10:17:30.586000', '2002-12-10 00:00:00.000000',
        'vanthuan2724@gmail.com', 'Trường Thuận', 0, 'https://drive.google.com/uc?id=1hKCUQJjbVFWl3bfFr7VMauWedTX2hivM',
        false, 'Nguyễn Văn', '$2a$10$ZOZ3i1uTPW1pepuM3JW7TO2NSESuorh.XNEoFc6TjSj3CnpY5mzcy',
        '2023-12-14 11:25:20.876000', 0xC0A801B98AC01A60818AC04A8FB50038),
       (0xC0A801B98AC51120818AC531341E0001, '2023-09-24 10:17:30.782000', '2005-12-20 00:00:00.000000',
        'thuhang2012@gmail.com', 'Thu Hằng', 1, 'https://drive.google.com/uc?id=1XwFb2p0v7RYMNC1Kcjh2fqT2hxnPzAoM',
        false, 'Trần', '$2a$10$A4zZFA4USlqW/b1Y.BXaUOACBR.L/yBZFbeQgZLoNobYSw/HEDaj.',
        '2023-12-14 10:29:11.535000', 0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC531349B0002, '2023-09-24 10:17:30.907000', '1999-01-06 00:00:00.000000',
        'phantu0601@gmail.com', 'Phan Tú', 0, null, false, 'Lê',
        '$2a$10$VEUZsVux1OnKIWG4RSBfKeXeDo.3Lz/a3NG81/hbNJAUvcV9CM9Y2', '2023-12-14 11:37:39.839000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC53135160003, '2023-09-24 10:17:31.030000', '1999-01-05 00:00:00.000000',
        'quocnam0501@gmail.com', 'Quốc Nam', 0, null, false, 'Lê',
        '$2a$10$0jPdtCcdVRWLyE0WSig8TOYfmxhR4R2gBDlr0H7xjxd04Cs153oty', '2023-12-14 10:27:46.320000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC53135900004, '2023-09-24 10:17:31.152000', '1995-09-27 00:00:00.000000',
        'lelinh2709@gmail.com', 'Lê Linh', 2, null, false, 'Hoàng',
        '$2a$10$sOBLA6Ab0wp/BPBvQsHnA.ZO4Nm.mW2DL3Qrk./vGqQvwd062N6Dm', '2023-12-14 11:42:02.728000',
        0xC0A801B98AC01A60818AC04A8FA60037),
       (0xC0A801B98AC51120818AC53136100005, '2023-09-24 10:17:31.280000', '1999-06-02 00:00:00.000000',
        'viethuy0206@gmail.com', 'Việt Huy', 0, null, false, 'Vũ',
        '$2a$10$SFyrrdRpYNaVB.xe67eleOIP2Gynkr7wJxjYPgCJKAJdDgQ7qSdyO', '2023-12-14 10:26:04.269000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC53136950006, '2023-12-24 10:17:31.413000', '2002-05-10 00:00:00.000000',
        'thanhdung1005@gmail.com', 'Tiến Dũng', 0, null, false, 'Ngô',
        '$2a$10$0uC76JPGICqIQpySWplSlubsfI3NSKKtc0wpWUo6LC8PIf2uF0.4G', '2023-12-14 10:25:20.039000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC53137130007, '2023-09-24 10:17:31.539000', '2002-08-15 00:00:00.000000',
        'quanhuy1508@gmail.com', 'Quan Huy', 0, null, false, 'Phan',
        '$2a$10$HlUzNfvvMSZm08aZkzXb0eZMdE5ViehvWQhaBPt5MsPqKkZ5WX.Lq', '2023-12-14 10:24:02.877000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC531378C0008, '2023-12-24 10:17:31.660000', '2000-01-05 00:00:00.000000',
        'phuoctuan0501@example.com', 'Thanh Phước Tuấn', 0,
        'https://drive.google.com/uc?id=1r3-bwzttqOv3zeA9V0AtPSL-aZkOCTsz', false, 'Lê',
        '$2a$10$rNlGugDXBLa.wnr39UrO/.Fw6SQWG.hq0H55kWtdJTzl67UnyUzu.', '2023-12-14 10:18:35.294000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC531380C0009, '2023-09-24 10:17:31.788000', '1997-07-09 00:00:00.000000',
        'thanhha0907@gmail.com', 'Thanh Hà', 1, null, false, 'Hoàng ',
        '$2a$10$evqtrZNn7Yzv/gCGok/gpO5XFAaF.jGK8U87L/B5wE44EPIqIG9AC', '2023-12-14 10:21:00.915000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313884000A, '2023-09-24 10:17:31.908000', '2023-09-24 10:17:31.797000',
        'thuhuong2409@gmail.com', 'Thu Hương', 1, null, false, 'Võ',
        '$2a$10$jMJ5PJ8ikfTYKftE.ittZeifSLnYoqmG1DBtgL2hRF8NT.L.m.uR2', '2023-12-14 11:38:44.467000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313900000B, '2023-09-24 10:17:32.032000', '2023-09-24 10:17:31.916000',
        'dang.khanh@example.com', 'Khánh', 1, null, false, 'Đặng',
        '$2a$10$cAsDLBIUYQGgvbaEEb4Po.dp4/rv3P0zOB6E4yl5diNR5RvxTyNtW', '2023-09-24 10:17:32.032000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC531397D000C, '2023-09-24 10:17:32.157000', '2000-06-06 00:00:00.000000',
        'thutrang0606@gmail.com', 'Thị Thu Trang', 2,
        'https://drive.google.com/uc?id=1sZscjC023yRey8O2RInVd3NImm48qtYc', false, 'Võ',
        '$2a$10$cLg66dpuw.ds9UzHaq4wiuXlnBbvKrr66ECQKOq0M1hYPVCkbyH0m', '2023-12-14 11:54:45.532000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC53139FC000D, '2023-09-24 10:17:32.284000', '2023-09-24 10:17:32.165000',
        'tran.hai@example.com', 'Hải', 1, null, false, 'Trần',
        '$2a$10$NMnr.pLKsI/LNismnFm2veBykoOyAHHQ65H1n.D62NQV9KT6ipxZW', '2023-09-24 10:17:32.284000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313A71000E, '2023-12-24 10:17:32.401000', '2023-09-24 10:17:32.292000',
        'pham.loan@example.com', 'Loan', 2, null, false, 'Phạm',
        '$2a$10$ElQYgKlNLYbKYl2ZTiLZYu0jDhP23sV2wNwh4XlTlKhFC941lZVRm', '2023-09-24 10:17:32.401000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313AEA000F, '2023-09-24 10:17:32.522000', '2023-09-24 10:17:32.410000',
        'ho.thao@example.com', 'Thảo', 2, null, false, 'Hồ',
        '$2a$10$WadEcKy/l0.BnW6kTdWJO.elNFz.XRWLsjvEVe35oDWD5YUwVX.AC', '2023-09-24 10:17:32.522000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313B610010, '2023-09-24 10:17:32.641000', '2023-09-24 10:17:32.530000',
        'le.tuan@example.com', 'Tuấn', 1, null, false, 'Lê',
        '$2a$10$HFNsxmGdRaahaz.InLyQD.Vm5nLFyfs4N1C4E2eEhL41VsQ4G02E6', '2023-09-24 10:17:32.641000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313C720012, '2023-12-24 10:17:32.914000', '2023-09-24 10:17:32.786000',
        'tran.hang2@example.com', 'Hằng', 2, null, false, 'Trần',
        '$2a$10$e80U4s5BZjBfrVa0IDrkJuD7xKq4iVTl67Z/T6OLTFLFsMzUIpc5C', '2023-09-24 10:17:32.914000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801B98AC51120818AC5313CED0013, '2023-09-24 10:17:33.037000', '2023-09-24 10:17:32.921000',
        'le.tu2@example.com', 'Tú', 1, null, false, 'Lê',
        '$2a$10$Xa7h0PS6AJRXXZLewG5fr.C9/KmmT.X136mSxKUtgfPTVDAjmDXui', '2023-09-24 10:17:33.037000',
        0xC0A801B98AC01A60818AC04A8F950035),
       (0xC0A801BB8C041058818C05EB7DF20000, '2023-11-25 16:59:28.495000', '2002-12-10 00:00:00.000000',
        'vanthuan7810@outlook.com.vn', 'Trường Thuận', 1,
        'https://drive.google.com/uc?id=1S8xAcj1xWTJjCb2-k9l-7lmpWKxLhC5-', false, 'Nguyễn Văn',
        '$2a$10$.3wAoXZ9vO4HSkljhgT1CexM0OiMop.oedh5hTGZd7hd09W.cBE1G', '2023-11-25 16:59:28.495000',
        0xC0A801B98AC01A60818AC04A8FA60037);