package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.PostReport;
import com.advanced_mobile_programing.docs_sharing.repository.IPostReportRepository;
import com.advanced_mobile_programing.docs_sharing.service.IPostReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class PostReportServiceImpl implements IPostReportService {
    private final IPostReportRepository postReportRepository;

    @Autowired
    public PostReportServiceImpl(IPostReportRepository postReportRepository) {
        this.postReportRepository = postReportRepository;
    }

    @Override
    public Page<PostReport> findAll(Pageable pageable) {
        return postReportRepository.findAll(pageable);
    }

    @Override
    public <S extends PostReport> S save(S entity) {
        return postReportRepository.save(entity);
    }

    @Override
    public Page<PostReport> findByIsRead(boolean isRead, Pageable pageable) {
        return postReportRepository.findByIsRead(isRead, pageable);
    }

    @Override
    public Optional<PostReport> findById(Integer integer) {
        return postReportRepository.findById(integer);
    }

    @Override
    public long countAll() {
        return postReportRepository.count();
    }

    @Override
    public long countByReportedAtYearAndMonth(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return postReportRepository.countByCreatedAtBetween(start, end);
    }

    @Override
    public long countByReportedAtYear(int year) {
        return postReportRepository.countByReportedAtYear(year);
    }
}
