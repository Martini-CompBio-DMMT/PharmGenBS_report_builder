#!/usr/bin/env Rscript

suppressPackageStartupMessages(library("argparse", lib.loc = "/vol1/DATA/PGx_project/R_locLib/R3.6.0-BiocC3.10"))

parser <- ArgumentParser(usage="Generate reports")

# N.B. If the report of the patient is already present the report will not be generated.
# Delete report manually to force new generation.

parser$add_argument("--file-info", default="../web_app/samples_info.tsv",
                    dest="file_info", help = "Patient information file")

parser$add_argument("--file-genos", default="../web_app/samples_genos.tsv",
                    dest="file_genos", help = "Patient genotype file")

args <- parser$parse_args()

.libPaths("/vol1/DATA/PGx_project/R_locLib/R3.6.0-BiocC3.10")

if (!require("PharmGenBS")) {
  stop("Package PharmGenBS not installed. Open script to find instructions on how to install")
}

if (0) {
  # dir.create(args$rlib_path, showWarnings = F)
  # .libPaths(args$rlib_path)

  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

  # BiocManager::install(pkgs[package_check], ask = F, update = F)
  devtools::install_github("Martini-CompBio-DMMT/PharmGenBS",
                           ref="main",
                           auth_token = "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"
  )
}


## Functions ##
create_reports <- function(file_info, file_genos) {
  # file_info <- "../web_app/samples_info.tsv"
  # file_genos <- "../web_app/samples_genos.tsv"
  suppressPackageStartupMessages(library(PharmGenBS))

  sample_info_table <- generate_sample_info_table(file_info, file_genos)
  patients <- sample_info_table$Sample

  all_patients_report <- lapply(patients, get_patient_clinical_guidelines, sample_info_table)
  names(all_patients_report) <- patients
  unformatted_reports <- all_patients_report

  for (patient in names(unformatted_reports)) {
    tbl <- unformatted_reports[[patient]]$short
    infos <- all_patients_report[[patient]]$long
    paziente <- patient

    output_dir = paste0("Report_PDF/", unformatted_reports[[patient]]$clinitian,
                        "/", unformatted_reports[[patient]]$clinitian)
    if (unformatted_reports[[patient]]$tau==0){
      output_dir = paste0(output_dir, "_TAU")
    } else {
      output_dir = paste0(output_dir, "_TGTG")
    }

    if (!unformatted_reports[[patient]]$tau %in% c(0,1))
      stop(paste("Unrecognize TAU value for patient",
                 paziente, "found", unformatted_reports[[patient]]$tau,
                 ". Expected 0 or 1"))

    if (!file.exists(paste0(output_dir, "/", paste0(patient, ".pdf")))){
      rmarkdown::render(input = "template.Rmd",
                        output_format = "pdf_document",
                        output_file = paste0(patient, ".pdf"),
                        output_dir = output_dir,
                        envir = new.env())
      detach("package:kableExtra", unload=TRUE)
    }
  }
}

## Connect to Prepare_data_Mac_v2.py

create_internal_reports <- function(file_info, file_genos) {
  # file_info <- "../web_app/samples_info.tsv"
  # file_genos <- "../web_app/samples_genos.tsv"

  suppressPackageStartupMessages(library(PharmGenBS))
  sample_info_table <- generate_sample_info_table(file_info, file_genos)
  patients <- sample_info_table$Sample

  all_patients_report <- lapply(patients, get_patient_clinical_guidelines, sample_info_table, remove_last=T)
  names(all_patients_report) <- patients
  unformatted_reports <- all_patients_report

  for (patient in names(unformatted_reports)) {
    tbl <- unformatted_reports[[patient]]$short
    infos <- all_patients_report[[patient]]$long
    paziente <- patient

    output_dir = paste0("Last_Drug_Report_PDF/", unformatted_reports[[patient]]$clinitian,
                        "/", unformatted_reports[[patient]]$clinitian)

    if (!unformatted_reports[[patient]]$tau %in% c(0,1))
      stop(paste("Unrecognize TAU value for patient",
                 paziente, "found", unformatted_reports[[patient]]$tau,
                 ". Expected 0 or 1"))

    if (unformatted_reports[[patient]]$tau==0){
      output_dir = paste0(output_dir, "_TAU")
    } else {
      output_dir = paste0(output_dir, "_TGTG")
    }

    if (!file.exists(paste0(output_dir, "/", paste0(patient, ".pdf")))){
      rmarkdown::render(input = "template.Rmd",
                        output_format = "pdf_document",
                        output_file = paste0(patient, ".pdf"),
                        output_dir = output_dir,
                        envir = new.env())
      detach("package:kableExtra", unload=TRUE)
    }
  }
}

## MAIN
create_reports(file_info = args$file_info, file_genos = args$file_genos)
create_internal_reports(file_info = args$file_info, file_genos = args$file_genos)

