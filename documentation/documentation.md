# Software installation

## Step 1: Install Docker for your system
The SubcellularDistribution pipeline is implemented using Docker in order to facilitate installation and reproducibility. Docker creates an isolated system on your computer, akin to a virtual machine. We provide instructions for Docker to recreate this container system across multiple different platforms. Visit [the Docker website](https://www.docker.com/) to download and install the Docker Desktop app for your computer. Follow their installation instructions.

Once you have installed Docker, we recommend adjusting the memory resources available to your Docker containers. On a Mac, this setting is available in the "Preferences" interface under "Resources". On the Windows Docker Desktop app, you can adjust this in the Advanced tab under "Settings". We suggest starting with a minimum of 5 GB of memory available.


## Step 2: Test git and install if necessary
You will use git to download the SubcellularDistribution pipeline code from GitHub. In order to test if you have git installed already, open up a terminal window and type:

```bash
git --version
```

If you see an error message that you don't have git, follow the instructions to install it [here for Mac](https://www.atlassian.com/git/tutorials/install-git#mac-os-x) or [here for PC](https://www.atlassian.com/git/tutorials/install-git#windows).

## Step 3: Download the SubcellularDistribution pipeline from GitHub
First, you should create a folder to contain your projects. We recommend something like a Projects folder within your home directory. Once you have created this folder, navigate to it using the terminal as follows:

Mac:
```bash
cd ~/Projects
```

Windows:
```bash
cd C:/Projects
```

Once you are in this directory, download the SubcellularDistribution pipeline code from GitHub using the command:

```bash
git clone https://github.com/pearlryder/subcellular-distribution-pipeline
```

Now you can navigate into this window using ```cd subcellular-distribution-pipeline```. You can test if the files have downloaded using ```ls```. You should see a printout to your terminal like this: ![terminal-git-clone](git-clone-ls.png).

## Step 4: Start the SubcellularDistribution pipeline using docker-compose




-- check to see if data is the




Download test data from FigShare
If you would like to test the code using our test dataset, you can download the dataset at [FigShare](https://figshare.com/projects/SubcellularDistribution_pipeline/86732). You will need to download the "centrosomes" and "rna" folders as well as the "raw-data-metadata.csv" file located within the "Supporting data for SubcellularDistribution Pipeline" dataset.

Note that you'll need to reorganize this data (detailed below), as FigShare does not allow us to share it with you in the nested folders required for the pipeline.

Once you've downloaded the data, create a folder named "image-data". Add both the centrosomes and rna folders to this image-data folder. Then, within the "centrosomes" folder, create a new folder named "raw-data". Move all of the images to this folder. Repeat this process for the "rna" folder. When you're done, your folder structure should look like this: ![image-data-folder-structure.png](image-data-folder-structure.png).





# get into container - bash

```bash
docker exec -it jupyter bash
```

# postgres into database
```bash
docker exec -it db psql -U username demo
```


*We assume that you will need to install software packages necessary for using the Allen Institute Cell Segmenter and present an abridged version of their installation process. See [their website](https://github.com/AllenInstitute/aics-segmentation) for up-to-date installation instructions.*

## Step 1: Install conda and the Allen Institute Cell Segmenter
#### 1.1 Anaconda installation
We use conda to manage the installation of python. You can download and install the latest version of Anaconda at [the Anaconda website](https://www.anaconda.com/). You'll note two versions are available - Anaconda is a full installation pre-loaded with many commonly used packages for data science, whereas miniconda is a stripped down version that saves on disk space. If you have the space, we recommend installing Anaconda to reduce the number of packages you need to load manually. Once you've installed conda, you can test if conda is active by typing the following command into your terminal window.

```bash
conda info
```

It's also a good idea to update your conda once you've installed it using `conda update --all`. In general, grey-blocked text indicates commands for the terminal.

#### 1.2 Test your pip installer
[pip](https://pip.pypa.io/en/stable/) is a package installer for Python. You can think of packages as discrete blocks of Python code that do specific tasks. Make sure you have pip installed by running

```bash
pip show pip
```

If any warnings appear when you run the command above, follow the screen instructions to update your pip installer.

#### 1.3 Install git
Git is a system for tracking changes to versions of code. You can use git to track the changes to  your own code (recommended) and to manage accessing the code for this pipeline and the Allen Institute Cell Segmenter. Check your own git installation:

```bash
git --version
```

If you're missing git, you can follow [this tutorial](https://www.atlassian.com/git/tutorials/install-git) for installation.

#### 1.4 Create a conda environment for the SubcellularDistribution pipeline
Create a new conda environment. This environment will contain all the Python packages necessary to segment images using the Allen Cell Segmenter. A separate environment will be used to run the SubcellularDistribution code. By using separate environments to run different code, we can avoid conflicts between packages (for example, our segmentation code requires a version of a package that is in conflict with code needed to process images, so we run the respective code from different environments).

```bash
conda create -n segmentation python=3.7 jupyter
conda create -n pipeline python=3.7 numpy psycopg2 seaborn postgresql==11.2 jupyter scikit-image
```


#### 1.5 Install packages into the segmentation environment
First, you'll want to activate your conda environment:

```bash
conda activate segmentation
```

Next, run the following commands to install the Allen Cell Segmenter and a package for interactive visualization of data.

```bash
conda install -c conda-forge opencv
pip install itkwidgets==0.14.0
pip install aicssegmentation==0.01.17
```

#### 1.6 Download the Allen  Cell Segmenter to a local folder
We've found that installing the cell segmenter using pip as described above is the most error-free way of installation for using the batch processor. However, it can be useful to download the cell segmenter from github in order to access their Jupyter notebooks and modify batch processing scripts locally. The following code creates a folder in your home directory named Projects and then downloads the Allen Cell Segmenter into that folder.

```bash
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/AllenInstitute/aics-segmentation.git
cd ~/Projects/aics-segmentation
```

#### 1.7 Test Allen Institute Cell Segmenter installation
Finally, you can test to see if your installation has worked by starting Jupyter notebook and opening the test_viewer.ipynb notebook.

```bash
conda activate segmentation
cd ~/Projects/aics-segmentation/lookup_table_demo
jupyter notebook
```
Use the "Run" button to advance through the cells. You can use the Allen Cell Segmenter to segment your objects of interest. We refer to their [excellent tutorials and documentation](https://github.com/AllenInstitute/aics-ml-segmentation/blob/master/docs/demo_1.md) for how to proceed. Your goal will be to have a folder of single-channel tif files containing the original images for your structure of interest and a corresponding folder of segmentations for those same images.

Note that we also provide optimized Jupyter notebooks and batch processing code for segmenting single molecule FISH and centrosome fluorescence images that work well for our images of *Drosophila* embryos.

#### 1.8 Download SubcellularDistribution pipeline code
You can download the code associated with the SubcellularDistribution pipeline from GitHub. The following terminal commands assume that you made a ~/Projects directory in step 1.6. You may choose to change this filepath.

```bash
cd ~/Projects
git clone https://github.com/pearlryder/subcellular-distribution-pipeline
cd ~/Projects/subcellular-distribution-pipeline
```

#### 1.9 Download test dataset
We provide a test dataset via FigShare. Visit [FigShare](https://figshare.com/projects/SubcellularDistribution_pipeline/86732) to download the images associated with this pipeline. Each image contains an RNA channel (channel 1) and a centrosome channel (channel 2). You can use Fiji (see below) to separate these images into single channel tifs as described in Step 2.

#### 1.10 Download Fiji and Atom text editor
We recommend using [Fiji](https://fiji.sc/) to visualize your images and segmentations. If you don't already have it, you'll want to download and install it.

If you don't have a preferred text editor, you may want to download and install the [Atom editor](https://atom.io/). We find that it's user friendly and makes editing code more straightforward than using the pre-installed text editor.

## Step 2: Organize data and segment images
For this pipeline, we recommend the following organization for your data. One directory contains a folder for each subcellular structure of interest. We recommend naming your single molecule FISH data "rna." In general, avoid naming structures with upper-case letters, numbers, or special characters - these don't play well with the database that you'll use later. Each structure folder should contain two folders, one for the raw data and one for the segmentations.

Within the folder for each subcellular structure of interest, you need to create two sub-folders, one named raw-data and and one named segmentations. Each of these folders contain single-channel .tif files for the structures of interest. Split the provided original images from the online repository into two channels. Save channel 1 (red; rna) to the raw-data folder within the rna folder. Create an empty "segmentations" folder within this "rna" folder. Next save the channel 2 tifs to the raw-data folder within the "centrosomes" folder and create the empty segmentations folder. An ImageJ macro can be helpful for converting from multi-channel formats into single-channel tifs and saving them to the raw-data folder for you automatically. You will generate segmentations using the Allen Cell Segmenter).

You likely want to use our pipeline to compare two (or more) biological conditions. We recommend creating a key for yourself to keep track of the associated experimental conditions for each image (we provide an example, raw-data-metadata.csv). This approach allows you to combine images from multiple replicates and conditions into the same folder, so you can be confident that you're applying the same process to each biological condition.

As you'll see in their tutorials, the Allen Cell Segmenter approach provides Jupyter notebooks called "playgrounds" to interactively visualize your segmentation workflow and optimize the parameters for your workflow. We provide two playgrounds for you to use with our test data: one optimized for segmentation of RNA (smFISH signals, in particular) and one optimized for segmentation of centrosomes. If your smFISH signals are similar to ours, you may find starting with our workflow helpful.

#### 2.1 Optimize parameters using Jupyter notebook playgrounds
For the purpose of this documentation, we'll walk through the process of segmenting smFISH signals. The process is the same for segmenting the centrosome data in our test dataset, you'll just need to use the corresponding Jupyter notebooks and batch processing scripts. If you have a different structure, you can use the [lookup table](https://www.allencell.org/segmenter.html) provided by the AllenInstitute to determine the best starting point for your segmentation.

Start by opening the playground_rna.ipynb Jupyter notebook.

```bash
conda activate segmentation
cd ~/Projects/subcellular-distribution-pipeline/optimized-segmentation-notebooks
jupyter notebook
```
Step through each cell of the playground_rna Jupyter notebook. These notebooks are interactive and allow you to visualize how each step of the workflow contributes to the final segmentation. We encourage you to adjust parameters and see how the output changes. For example, if the gaussian smoothing sigma starts at 1, try 0.1 and 5 to see how these changes affect the smoothing process. You can save final segmentations using the final cell. These will automatically save into a sub-folder named test-segmentations, that is already created for you. You may also want to save intermediate segmentations, such as the bw_extra segmentation from the 3D spot filter. In order to do this, you would replace the variable 'seg' in the final cell with 'bw_extra' and re-name the output name. For example, from:
```bash
seg = seg >0
out=seg.astype(np.uint8)
out[out>0]=255
writer = omeTifWriter.OmeTifWriter('test-segmentations/' + FILE_NAME + '_test_rna_segmentation.tiff')
writer.save(out)
```
to
```bash
bw_extra = bw_extra >0
out=bw_extra.astype(np.uint8)
out[out>0]=255
writer = omeTifWriter.OmeTifWriter('test-segmentations/' + FILE_NAME + '_test_rna_bw_extra.tiff')
writer.save(out)
```
Downloading images is useful, because I've found that I can better assess the quality of segmentation using Fiji. I like to open the original image and a segmentation file in Fiji and then use the Sync Windows function to directly compare the images. For smFISH signals, you want to assess the following questions:
* Are single molecules of RNA captured?
* Is the background appropriately excluded?
* If you have larger granules, as we do in one of our biological conditions, are those granules segmented appropriately?

Note that no segmentation process will ever be perfect. We refer you to this [excellent article](https://blog.cellprofiler.org/2019/10/21/when-to-say-good-enough/) by Beth Cimini, a senior computational biologist in the Imaging Platform led by Anne Carpenter at the Broad Institute, for a philosophical discussion of when to call a workflow "good enough." Remember, you want to robustly quantify the difference between two biological states as accurately as feasible, while recognizing that discovering the "universal truth" of your biological process is impossible.

Continue this process until you're satisfied with the segmentation process. We recommend walking through at least two images from each biological condition to test your workflow before moving to the next step -- batch processing.

#### 2.2 Batch process image segmentation
Once we're satisfied with my workflow, we use the Allen Cell Segmenter's batch processing mode to segment our entire dataset. We then review the results of that segmentation for each image in Fiji (or a representative subset of your images if your dataset is really big).

If you changed the parameters in the Jupyter notebook for RNA segmentation, then you'll first want to update the batch processing file for RNA named "seg_rna.py" and located in the "batch-processing-scripts" folder. Open the file using a text editor. Update the code using copy-paste so that the pre-processing, processing, and post-processing steps reflect the workflow you optimized in step 2.1. [This tutorial](https://www.youtube.com/watch?v=Ynl_Yt9N8p4) may be helpful.

Once you've updated your seg_rna.py code, you'll need to copy it into the folder that contains the Allen Institute Cell Segmenter in your conda environment for segmentation. The easiest way we've found to identify where my anaconda environment is stored on my computer is to search for a batch processing workflow using:
```bash
 mdfind seg_cetn2.py
```
You'll see something like:
```bash
/Users/pearlryder/Projects/aics-segmentation/aicssegmentation/structure_wrapper/seg_cetn2.py
/Users/pearlryder/opt/anaconda3/envs/segmentation/lib/python3.7/site-packages/aicssegmentation/structure_wrapper/seg_cetn2.py
/Users/pearlryder/opt/anaconda3/envs/segmentation/lib/python3.7/site-packages/aicssegmentation-0.1.17.dist-info/RECORD
/Users/pearlryder/Projects/aics-segmentation/aicssegmentation.egg-info/SOURCES.txt
```
This output signifies that I have two locations for the Allen Institute Cell Segmenter batch processing workflows: one located at  ```/Users/pearlryder/Projects/aics-segmentation/aicssegmentation/structure_wrapper/seg_cetn2.py``` and one at ```/Users/pearlryder/opt/anaconda3/envs/segmentation/lib/python3.7/site-packages/aicssegmentation/structure_wrapper/seg_cetn2.py```. As you can see, the anaconda3 path is the one we're looking for. Now, you can copy your seg_rna.py code into the structure_wrapper folder in the anaconda3 environment:

```bash
cp ~/Projects/subcellular-distribution-pipeline/batch-processing-scripts/seg_rna.py ~/opt/anaconda3/envs/segmentation/lib/python3.7/site-packages/aicssegmentation/structure_wrapper/
```

Once you've copied your batch processing code into the anaconda folder, you're ready to batch process your images. The following code should work, although you may need to change the input and output_dir paths, depending on where your raw data is stored.

```bash
batch_processing --workflow_name rna --struct_ch 0 --output_dir ~/data/rna/segmentations per_dir --input_dir ~/data/rna/raw-data --data_type .tif
```

If all goes well, you should see printed updates on the image normalization process and the output directory will start to fill up with segmented files. These usually take ~ 10 minutes to run, depending on the number of images you're segmenting and your computer. You can start comparing the segmentation output to your original files during this time - or take a coffee break.

We often find that once we batch process the images, we need to tweak our parameters. You can do this by directly modifying your seg_rna.py file and repeating the batch processing or by returning to the Jupyter notebook. If you edit the seg_rna.py file that's located in your subcellular-distribution-pipeline folder, you'll need to repeat the copy command above to update it in the anaconda3 folder. Note that the segmenter will not overwrite files, so you'll either want to provide a new directory for the output or delete previous segmentations if you're repeating the batch processing.

Once you're satisfied with the segmentations for your smFISH signal, you'll want to repeat the same process for your other structures of interest. If you're using our test-data to learn the workflow, you can repeat the steps above using the playground_centrosomes.ipynb Jupyter notebook and the seg_cent.py workflow. Here's an example of the command to copy the seg_cent.py batch processing workflow into your anaconda folder:

```bash
cp ~/Projects/subcellular-distribution-pipeline/batch-processing-scripts/seg_cent.py ~/opt/anaconda3/envs/segmentation/lib/python3.7/site-packages/aicssegmentation/structure_wrapper/
```

 Note that when you run the batch processing command, you'll need to update the workflow name and the input and output directories, e.g.:

```bash
batch_processing --workflow_name cent --struct_ch 0 --output_dir ~/data/centrosomes/segmentations per_dir --input_dir ~/data/centrosomes/raw-data --data_type .tif
```

## Step 3: Set up database server
#### 3.1 Install postgres
First, we need to set up a postgres server and database for this experiment. We use one database to contain all of the data for a given experiment, including multiple replicates and different biological conditions that are being compared.

Use conda list to ensure that you have postgresql installed in your pipeline environment:
```bash
conda activate pipeline
conda list
```

If you don't see `postgresql 11.2` in your list of packages, you can use `conda install -c anaconda postgresql=='11.2'` to install it.

#### 3.2 Initialize a postgres server
The next step is to create folders for your database server information and a place to hold your collection of databases. You'll be prompted to enter your system password. Be sure to update your username in the commands below. If you're not certain of your username, you can use the whoami command to find out:

```bash
sudo mkdir -p ~/usr/local/pgsql/data
sudo chown username ~/usr/local/pgsql/data
sudo chmod -R 700 ~/usr/local/pgsql/data
pg_ctl -D ~/usr/local/pgsql/data initdb
```

If everything works, you'll see a printout to your terminal window indicating the successful initiation of your database cluster. Now you can start your server using the following command. Note that you may need to change the path to your anaconda installation of postgres - the terminal window should have this command printed out. Note this process creates a logfile in your Projects/subcellular-distribution-pipeline directory, which you can use to debug any errors:

``` bash
~/opt/anaconda3/envs/pipeline/bin/pg_ctl -D ~/usr/local/pgsql/data -l ~/Projects/subcellular-distribution-pipeline/logfile start
```

#### 3.3 Create a database for your data
Now we'll create an initial database. This database will be named for your username and is the starting point for creating other databases. We'll first create a database for your username with the createdb command, then create a database called "demo" for the tutorial data.

``` bash
conda activate pipeline
createdb
createdb demo
```

#### 3.4 Interact with your data using the postgres command line utility
Finally, you can interact with your databases using SQL commands from a terminal window by activating the postgres command line utility. You may want to open a new terminal window that you use for this purpose exclusively. If you do, you'll need to be sure to activate your conda environment before running the following commands. The first command launches the postgres command line utility, while the second command is an SQL command that connects you to the demo database:

``` bash
psql
\c demo
```

When you're done interacting with your databases using SQL, you can stop postgres command line utility by typing ```quit```

#### 3.5 Stop your server when you finish
It's good practice to stop the server when you're done:

``` bash
pg_ctl stop -D ~/usr/local/pgsql/data
```
You're now ready to extract information from your segmented images! The standard way that we'll execute this code is from Jupyter notebooks.

## Step 4: Run the SubcellularDistribution pipeline
#### 4.1 Open the pipeline.ipynb jupyter notebook
Navigate in the terminal to your subcellular-distribution-pipeline folder and launch Jupyter notebook. Note the command below is specialized to allow for the processing needed for distance measurements.

```bash
cd ~/Projects/subcellular-distribution-pipeline
jupyter notebook --NotebookApp.iopub_data_rate_limit=100000000
```

Launching this script should open your browser window. Navigate to 'pipeline-notebooks' and open the 'pipeline.ipynb' notebook.

#### 4.2 Update parameters in cell 1
The first step for this pipeline is to update your parameters. You named your database in step 3.3 above. Your database username is probably your system username, unless you specified something different in the step above. Your password will probably be an empty string and the host name should be "localhost". You will want to be sure that you've started your postgres server, so that Jupyter notebook can communicate with your database.

Next, update the path to find the raw data and segmented images. You'll also need to update the directory names for your raw data and segmentations.

The default output for the Allen Institute Cell Segmenter adds a suffix to the end of the file names. The localization pipeline can accommodate if your segmentation files have a different suffix than your raw data files. Update the segmentation_file_suffix variable accordingly. If your segmentation files have the same name as the raw data, then change this variable to an empty string ('').

Finally, update the scale parameters for your pipeline. The pipeline uses these scales to convert from pixels to microns for the distance measurements. Note that the "z_scale" is the your step size in the z dimension.

#### 4.3 Extract basic object data
The next step is to extract intensity data for each object and store it in the postgres database. The first cell in this section loads the packages and functions necessary for object extraction.

Next, tables are created in your database to hold the data for each structure of interest. The tables will be named based on the names of your structures that you defined in Step 4.2. Remember that those names should correspond to the name of the folder containing the raw-data and segmentations for that structure.

The third cell navigates through your data and extracts intensity information for each subcellular structure of interest. That data is then inserted into the structure table in the your database.

After running the third cell, you should see a printout indicating the image name and its status.

Note that data are not reprocessed - if the database already contains object data for a structure for a given image, the image is skipped. If you need to delete object data for a structure in a particular image, use the `delete_data_db(image_name, structure, conn)` function

In a new cell, you would run:
```bash
from pipeline import delete_data_db
conn = psycopg2.connect(database=database_name, user=db_user, password=db_password, host=db_host)
image_name = ''
structure = ''
delete_data_db(image_name, structure, database_name, db_user, db_password, db_host)
```
Update the image_name and structure variables with the respective image names and structures.

You can check to see if your database was updated using the command line utility in terminal.

```bash
psql
\c demo
\dt
```

The `\dt` command will show you the tables contained in your database. You should see tables for each of your subcellular structures. From there, you can select some data from each structure table to verify that it was properly inserted:

```bash
SELECT * from structure_table_name limit 20;
```

#### 4.3 Measure distances between two subcellular structures
Our approach is to first extract intensity data about all subcellular structures (Step 4.2 above) prior to measuring distances between select pairs of subcellular structures. For the distance measurements process, you'll need to update the variables for the parameters.

We designate the pairs of subcellular structures to measure using the format `[(structure_1, structure_2), (structure_1, structure_3)]`. Each pair of subcellular structures is enclosed within parentheses. For each object in the first structure in the parentheses, the closest distance to the second structure is measured. You can include multiple pairs of structures to measure between - e.g. [('rna', 'centrosomes'), ('rna', 'nuclei')] would measure the distance for each rna object to the nearest centrosome and the nearest nucleus.


The next variable determines how the processing proceeds. If your computer has multiple cores, then you may want to take advantage of parallel processing to decrease the total time to process your images. To do so, set the parallel_processing_bool variable to True.

Finally, we give you an option to determine how many pairs of objects are measured using the surface coordinates through the `number_centroid_measure` variable. This pipeline's approach is to first measure the distances between objects using the centroid coordinates. Then, a select number of the closest pairs of objects are measured using the surface coordinates. This approach minimizes processing time. If both subcellular structures are densely packed (such as two smFISH signals), then you may want to increase the number of objects measured using the surface coordinates.

After package import, the following cell creates columns in your structure one table to hold your distance_to_structure_2 and structure_2_id data. These columns will be named "distance_to_" + "structure_2" and "structure_2" + "\_id". For example, if you are using our demo dataset, then your rna table will contain two new columns named "distance_to_centrosomes" and "centrosomes_id" after running this cell. These columns are only created if they do not already exist (data is not overwritten).

To check that your columns were created properly, return to the terminal and connect to your database. The run the SQL command below to select data from your rna table:

```bash
psql
\c demo
SELECT name, distance_to_centrosomes, centrosomes_id from rna limit 5;
```

You should see two new empty columns ready to accept your distance and structure_2_id data.

Once you've verified that the database is ready to accept distance measurements data, run the next cell to measure distances between the two subcellular structures. Our test dataset of 20 images takes about 9 hours to run on a MacBook Pro with a 12-core processor using parallel processing. If the processing time is too slow on your computer, then processing on a virtual machine using Amazon Web Services may be an option you want to explore.

#### 4.4 Create an images table
Your raw-data images folder likely contains images of a control biological condition together with images from your experimental condition. You may also have multiple biological replicates or images from different biological conditions, such as developmental stages. You can use postgres to help track where each image comes from -- e.g. is it an image of control condition or an experimental condition?

We recommend storing these data in a .csv file. We provide an example .csv file `raw-data-metadata.csv` with our sample dataset. You can create this file for your own experiment using Excel and then "Save As" .csv (you specifically want the "Comma Separated Values" file type and not the "CSV UTF-8" file type). The first row of your .csv file should contain labels that will become column names when you upload this data to postgres.

In the first cell of this section, you'll want to update the filepath to the directory that contains your .csv file. If you are using our sample dataset, then this directory is the same directory that contains your images. Also update the name of your csv file in this cell.

The third cell opens your csv file and prints out the column names for you. This printout is intended to help you update the SQL query in the following cell. That SQL query creates a new table in your database named 'images'. The text contained in parentheses

``` bash
(name TEXT NOT NULL,
rna_type TEXT,
cycle TEXT,
stage TEXT,
replicate INT)
```

describes the columns that will be contained in this new table. You will need to update this command to have the columns match the columns in your csv file. The uppercase word that follows the column name indicates the data type for the column. For example the command `name TEXT NOT NULL` creates a column in the table named 'name' that contains text data and cannot be null (a good idea for the name column, since this column is how we will match objects in the structure tables with metadata about each images). To learn more about SQL data types, you can visit [this website](https://www.postgresqltutorial.com/postgresql-data-types/). Useful datatypes include TEXT (variable-length character string), INT (integer), and REAL (non-integer numbers). After you edit the query and run this cell, the updated query will be printed for you to verify that you've edited it properly. Note that this command will not overwrite a table if it already exists ("CREATE TABLE IF NOT EXISTS").

The last cell in this section copies data from your csv file into your new images table. An additional command (add_id_column) adds an id column of integers that autopopulates incrementally. Note that this cell can only be run once because after you've created an id column, then the columns in your images table will no longer match the columns in your csv file. This approach is useful to prevent overwriting of your images table.

If you need to overwrite the data in your images table, then it's probably best to connect to your postgres database using the command line utility to then drop the images table and start again. For example:

``` bash
psql
\c demo
DROP TABLE images;
```

As long as you have your csv file, it should be easy to recreate the images table. You can check your images table for data upload in the terminal using:

```bash
psql
\c demo
SELECT * from images;
```

#### 4.5 Normalize single molecules per object (optional)

This section estimates the number of molecules per object for single molecule data. The logic of this method is that it estimates the integrated intensity (also called the total intensity in the database) of small objects for a given structure. These small objects are identified using a volume threshold. For our data, we opened several representative images of smFISH data imaged at 100x on our spinning disk confocal microscope in Fiji and measured the size of individual molecules of RNA in pixels. Fiji's oval tool is helpful to measure the diameter of single molecules in multiple z slices. These measurements can help you estimate the number of pixels that represent a single molecule establish the upper and lower area parameters for your own data.

The first cell requires you to define parameters for the name of the table that contains your RNA data. This cell is where you define the upper and lower thresholds for your small objects and the names of your single molecule data types. After importing packages, the next cell adds columns to your structure table to hold the normalized intensity data.

The following cell contains an SQL query that calculates the average integrated intensity of structure_1 objects within the area parameters that you previously defined (lower_threshold and upper_threshold) for each data type in your experiment. In the next cell, the integrated intensity of each object of that subcellular structure is divided by this small object average and saved in your normalized_intensity column.

Once you run this code, you can connect to your database using the command line utility to check if you now have a column named "normalized_intensity" that has been updated. As you see below, we check this for both of the RNA types in our test dataset.

```bash
psql
\c demo
SELECT * from rna WHERE rna_type = 'cen' limit 10;
SELECT * from rna WHERE rna_type = 'gapdh' limit 10;
```

#### 4.6 Calculate the percent distribution and cumulative percent distribution of structure_1 relative to the distance from structure_2
We find that distribution profiles and cumulative distribution profiles are very powerful to visualize differences in the spatial distribution of RNAs relative to subcellular objects of interest.

The first step is to update the parameters. The structure_1 and structure_2 parameters are the same parameters that were used in the distance measurements section. In that section, you created a column in the structure_1 table called "distance_to_structure_2" containing a distance in microns for each structure_1 object. The "image_name_column" parameter is the name of the column in your images table that holds the image names data.

Next, you'll need to define the step_size parameter. This parameter sets the interval size for calculating the percentage of RNA. For example, if you set step_size = 0.05, then the pipeline will calculate the percentage of total RNA and the percentage of total RNA in granules that localizes within 0, 0.05, 0.10, 0.15 microns up to your distance threshold.

You'll also need to decide if you want to set a threshold for how far an RNA object can be from a structure_2 object and still be considered a "true" RNA object. For example, our data from early embryos often contains RNA objects that are outside of cellular structures and represent background data. The precise and consistent geometry of the early embryo allows us to set an upper limit depending on developmental stage for how far away from a centrosome an RNA object can be. Setting this threshold helps our plots to appear consistent between images, but we've noted that it doesn't affect our conclusions. If you do not want to set such a threshold, you can define ```distance_threshold = None``` and the pipeline will calculate the cumulative percent of total RNA up to the maximum distance_to_structure_2 for each image.

If your dataset has single molecule data that you normalized in step 4.5, then you have the option to measure the distribution of clusters of your single molecule data. For example, you can estimate the distribution of objects containing at least 4 molecules by setting `granule_bool = True` and `granule_threshold = 4`.

Finally, you will need to define the directory where you want to save .csv files of the calculated distribution data. By default, we choose to save all output to a folder within your data directory named "output". Within the output folder, the pipeline creates a "data" folder to hold these files. This directory is printed out to help you find the .csv files. The next cell creates the output and data folders if they don't already exist.

The next two sections calculate the distribution and cumulative distribution of structure_1 relative to the distance from structure_2 and save the output as .csv files. In the following sections, you can plot these data.  

#### 4.7 Plot cumulative distribution data
In this section, we provide examples of how to plot the RNA distribution data using the Seaborn library. Our method allows you to create line graphs plotting the cumulative distribution of structure_1 relative to the distance from structure_2. Note that there are many options for subsetting your data according to different variables from your images table, many of which we can't anticipate. We refer you to the excellent [Seaborn tutorials](https://seaborn.pydata.org/tutorial.html), which can help you customize your plots.

As usual, the first cell of this section imports the necessary packages. The next cell is where you adapt the parameters for your data. The `fractional_distribution_data_filename` variable is the name of the .csv file containing data for the percent of structure_1 relative to the distance from structure_2. The `cumulative_distribution_data_filename` variable is the name of the .csv file that contains the data for cumulative RNA distributions. Both .csv files were calculated and saved in section 4.6. `data_output_dir` is the path to the directory where the distribution data file is stored. This directory will also be used to save csv files containing subsets of your RNA distribution data, as discussed below. Finally, you can specify a directory where you would like to save the plots that you generate in this section. By default, these plots are saved in the output folder, under a sub-directory named plots. The next cell creates this plots directory, if it does not already exist.

In the fourth cell of this section, we provide a function for you to save your plots. By defining a function, you can save all your plots using the same parameters. We use matplotlib's [savefig function](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.savefig.html), which has several optional parameters that you can adjust as appropriate for your work. By default, we set `dpi = 600` and `format = 'pdf'`, which we've found work well for building figures.


Next the distribution file is loaded into a pandas dataframe. In essence, dataframes function much like spreadsheets. You can learn more at [the pandas website](https://pandas.pydata.org/). The first 10 rows of your dataframe are shown in the output window. Verify that you see the expected columns and that the distances increase in the predicted increments.

Next, we generate a [Seaborn lineplot](https://seaborn.pydata.org/tutorial/relational.html#emphasizing-continuity-with-line-plots) that shows the percentage of total RNA relative to distance from the centrosome. The mean percentage of RNA is shown as a dark line with shading to indicate the standard deviation at each distance measurement. These calculations were made on a per image basis in the previous section. As you can see, we use the `rna_type` variable to separate the data according to the RNA type, allowing us to compare the distribution of centrocortin RNA relative to gapdh RNA in our demo dataset. We also use the `cycle` variable to separate the data according to cell cycle in two different columns.

We encourage you to explore the power of Seaborn plotting. What happens if you change `col = 'cycle'` to `row = 'cycle'`? Do you have an additional variable that you'd like use for plotting? For example, one can imaging having both an `rna_type` variable and a `genotype` variable that are of interest. Perhaps you are investigating the distribution of an RNA type that you predict to mislocalize in a mutant genotype relative to a RNA type that you predict will not be affected by the mutant genotype. In that case, you could continue to use `hue = 'rna_type'` and `col = 'cycle'`, while adding in a `row = 'genotype'` parameter. The plotting methods are very flexible, but do require an investment to learn.

The next two cells repeat the same plotting process but plot the percent of total RNA that is contained in granules relative to the distance from your subcellular target of interest. In order to make this change, we simply change the name of the variable that contains the plot to `percent_granule_plt` and then change the y variable to `y = percent_granule_rna`. Once you're satisfied with this plot, the save_plot function is used to optionally save the plot to disk.

We also provide examples of changing the x-axis on these plots to focus on the distribution of the structure 1 objects that are closest to structure 2. We then repeat these plotting examples using the cumulative distribution data.

Finally, we provide examples of how to subset your data and explore it. In order to subset our data, we use a the `.loc` method on the dataframe. You can read more in the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.loc.html). In this example, we get all datapoints where the distance is equal to 1 using the code:

``` bash
less_than_1_micron_distribution_df = cumulative_distribution_df.loc[cumulative_distribution_df['distance'] == 1]
```
Note the use of two equals signs - since one equals sign is used to assign variables, python uses two in a row to indicate testing for equality.  If you were to require that `distance = 1`, python will respond with an invalid syntax error.

Maybe you're especially interested in how a structure_1 is distributed at further distances from structure_2 and you want to get a subset of the data where all datapoints are at least 1 micron away from that structure. In that case, you could change the code from <= 1 to >= 1, as follows:

``` bash
greater_than_1_micron_distribution_df = cumulative_distribution_df.loc[cumulative_distribution_df['distance'] >= 1]
```

We provide code to save this subsetted data as a .csv file and then provide an example of plotting this data as individual data points with an overlying boxplot to show the quartiles and distribution of the data. You can read more about plotting this type of data in the [Seaborn tutorials](https://seaborn.pydata.org/tutorial/categorical.html#categorical-tutorial). Once you've come up with a plotting scheme that you're happy with, you can save the plots using the save_plot function.

#### 4.8 Save .csv files of your raw object data
The last section of this pipeline provides an opportunity for you to save backups of your database as .csv files. In the following step, we also provide directions on how to create postgres backup database files. However, we know it can be reassuring to have a backup of your data that can be viewed using standard text editors rather than a specialized program like postgres.

In this section, you will need to specify parameters for where you would like to save these csv files. By default, the pipeline will save these files to `output/db_backups/db_csvs`. The filenames are named according to a `year.month.day-table_name.csv` format.

That's the end of the pipeline notebook! There is one more recommended step - saving a database backup through the terminal - but otherwise you've made it through the localization pipeline. Congrats!

## Step 5: Save save save your data
Finally, we'll tackle saving backup files of your database and how to restore the data into a new postgres database. These approaches are useful to have confidence that your data is secure and may help you run this code on virtual machines, such as using Amazon Web Services. We'll use the postgres
[pg_dump utility](https://www.postgresql.org/docs/9.1/app-pgdump.html) to back up the database. As a default, our directions compress the backup file using [gzip](https://www.gzip.org/). First, navigate to the folder where you'd like your database backups to be stored. We recommend storing these in the data/output/db_backups folder, as shown below.

```bash
cd ~/data/output/db_backups
pwd
pg_dump database_name | gzip > filename.gz
```

Note that this process may take several minutes, depending on the size of your database. Once you've made the backup, you can test a restore as follows:

recreate the database
```bash
createdb new_database
gunzip < filename.gz | psql new_database   
```

You should be able to interact with this database using the postgres command line utility and verify that it contains all the expected data. Once you're satisfied, you can delete databases (if desired) as follows:

```bash
psql postgres
DROP DATABASE database_name;
```
