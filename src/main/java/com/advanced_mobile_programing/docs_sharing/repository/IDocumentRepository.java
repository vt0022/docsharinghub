package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface IDocumentRepository extends JpaRepository<Document, Integer> {
    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q)")
    Page<Document> findAll
            (String q, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.category IN :categories")
    Page<Document> findAllByCategories
            (String q, List<Category> categories, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.field IN :fields")
    Page<Document> findAllByFields
            (String q, List<Field> fields, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.category IN :categories " +
            "AND d.field IN :fields")
    Page<Document> findAllByCategoriesAndFields
            (String q, List<Category> categories, List<Field> fields, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "ORDER BY SIZE(d.documentLikes) DESC")
    Page<Document> findAllOrderByLikes(String q, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.category IN :categories " +
            "AND d.field IN :fields " +
            "ORDER BY SIZE(d.documentLikes) DESC")
    Page<Document> findAllByFieldsAndCategoriesOrderByLikes(String q, List<Category> categories, List<Field> fields, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.category IN :categories " +
            "ORDER BY SIZE(d.documentLikes) DESC")
    Page<Document> findAllByCategoriesOrderByLikes(String q, List<Category> categories, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND d.field IN :fields " +
            "ORDER BY SIZE(d.documentLikes) DESC")
    Page<Document> findAllByFieldsOrderByLikes(String q, List<Field> fields, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND :tag MEMBER OF d.tags")
    Page<Document> findAllByTags(String q, Tag tag, Pageable pageable);

    @Query("SELECT d FROM Document d " +
            "WHERE (LOWER(d.docName) LIKE :q OR LOWER(d.docIntroduction) LIKE :q) " +
            "AND :tag MEMBER OF d.tags " +
            "ORDER BY SIZE(d.documentLikes) DESC")
    Page<Document> findAllByTagsOrderByLikes(String q, Tag tag, Pageable pageable);

    Page<Document> findByUser(User user, Pageable pageable);

    @Query("SELECT COUNT(d) FROM Document d WHERE d.uploadedAt >= :start AND d.uploadedAt < :end")
    long countByUploadedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(d) FROM Document d WHERE YEAR(d.uploadedAt) = :year")
    long countByUploadedAtYear(@Param("year") int year);
}
