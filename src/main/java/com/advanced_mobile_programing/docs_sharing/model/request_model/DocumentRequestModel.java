package com.advanced_mobile_programing.docs_sharing.model.request_model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DocumentRequestModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private String docName;
    private String docIntroduction;
    private String viewUrl;
    private String downloadUrl;
    private String thumbnail;
    private int categoryId;
    private int fieldId;
}