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
                         ref="main")

## Create the reports [FIRST time]

Create an empty directory with your favourite names (e.g. PGx_project).

Go to [Martini-CompBio-DMMT](https://github.com/Martini-CompBio-DMMT) and download the project called [PharmGenBS_report_builder](https://github.com/Martini-CompBio-DMMT/PharmGenBS_report_builder).
Save/move all downloaded files in the directory PGx_project

Moreover, import "samples_info.tsv" and "samples_genos.tsv" from the web_app directory from the server.

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


## Create the reports

If you have already run "create_reports" at least once and you want to create additional reports just open the project (double click on the file .Rproj in the directory).

Once Rstudio is open, update "samples_info.tsv" and "samples_genos.tsv" files with new patients.

Then run:

        library(PharmGenBS)
        create_reports(file_info = "samples_info.tsv",
        file_genos = "samples_genos.tsv")

__Please NOTE: if a report for a patient has already been done the patients with not be processed again. Only patients with no PDF report will be done. To trigger the building of a new report for patients that were already processed delete corresponding old report.__



