# PharmGenBS_report_builder

## Installation
Make sure that the following software are installed in your computer:
 * pdfLatex/MiKTeX
 * R
 * Rstudio

Open Rstudio.

If you don't have install _BiocManager_ R package.

    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")

Install packages kableExtra, rmarkdown and devtools

    BiocManager::install(c("kableExtra", "rmarkdown", "devtools"))

Install the package PharmGenBS from github repository [Martini-CompBio-DMMT](https://github.com/Martini-CompBio-DMMT)

    devtools::install_github("Martini-CompBio-DMMT/PharmGenBS",
                         ref="main",
                         auth_token = "the token goes here")

## Create the reports [FIRST time]

Create an empty directory with your favourite names (e.g. PGx_project).

Go to [Martini-CompBio-DMMT](https://github.com/Martini-CompBio-DMMT) and download the project called PharmGenBS_report_builder(https://github.com/Martini-CompBio-DMMT/PharmGenBS_report_builder).
Save/move all downloaded files in the directory PGx_project

Moreover, import samples_info.tsv and samples_genos.tsv from the web_app directory in the server.

Open Rstudio

Make File -> New Prject -> Existing Directory

As existing directory use your directory, e.g. PGx_project.

Rstudio should open a new window and the working directory should be correctly placed in PGx_project.

From right hand bottom corner, open file "build_reports_manual.R".
To create reports run the command:

        library(PharmGenBS)
        create_reports(file_info = "samples_info.tsv",
        file_genos = "samples_genos.tsv")
        

To create reports for internal use run the command:
    
    library(PharmGenBS)

    create_internal_reports(file_info = "samples_info.tsv",
    file_genos = "samples_genos.tsv")

