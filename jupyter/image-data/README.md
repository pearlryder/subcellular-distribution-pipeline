The purpose of this folder is to hold your image data for analysis.

You should add your imaging data in the following format:

Each structure of interest has its own folder, named in all lowercase for the structure (e.g. "rna", "centrosomes").

Within that "structure" folder, a "raw-data" folder will exist that has single channel .tif files of the structure.

You should also add a .csv file containing the metadata for your images (e.g. detailing which biological condition each image represents).

You can download sample "centrosomes" and "rna" images to test this pipeline at [FigShare](https://figshare.com/projects/SubcellularDistribution_pipeline/86732). The example metadata table is located in the "Supporting data for SubcellularDistribution Pipeline" dataset.

Here is an example of the this folder's file structure:
![image-data-folder-structure.png](.../documentation/image-data-folder-structure.png)
