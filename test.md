.. Training documentation master file, created by
   sphinx-quickstart on Wed Jan 21 11:19:05 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

BRUKER NMR TRAINING
====================================

Introduction
--------------

The goal of this guide is to enable a relatively inexperienced user to carry out a series of basic 1-D High Resolution (HR) NMR experiments. Both Proton observe and Carbon observe will be described. While every effort has been made to genuinely provide a step by step description, new users will invariably have some questions, and as such will require occasional assistance from NMR staff. The goal of this manual is, where practicable, to enable users to work independently and acquire a basic understanding of how to operate the system.


Safety
---------

For such a sophisticated system there are surprisingly few opportunities for inexperienced users to damage the equipment. New users are advised to acquaint themselves with these potential hazards before commencing.


	****People fitted with cardiac pacemakers or metallic implants should never be allowed near the magnet!****

.. image:: _static/mag.jpeg
   :align: right
   :alt: nmr_magnet

The magnet is potentially hazardous due to:

 * The large attractive force it exerts on ferromagnetic objects.			
 * The large content of liquid nitrogen and helium.

-----------------
 Magnetic Safety
-----------------
A magnetic field surrounds the magnet in all directions. This field (*known as the stray field*) is invisible. Objects made of ferromagnetic materials, e.g. iron, steel etc. will be attracted to the magnet. If a ferromagnetic object is brought too close, it may suddenly be drawn into the magnet with surprising force. This may damage the magnet, or cause personal injury to anybody in the way! Do not allow small steel  bjects (screwdrivers, bolts etc.) near the magnet. These could cause serious damage if drawn into the magnet bore.

-----------------
Cryogenic Safety
-----------------
The magnet contains relatively large quantities of liquid helium and nitrogen. These liquids, referred to as cryogens, serve to keep the magnet core at a very low temperature. Direct contact with these liquids can cause frostbite. Exit the space immediately in the event of a magnet quench, whereupon the room may suddenly fill with evaporated gases reducing the level of oxygen needed to sustain life. 

-----------------
Chemical Safety
-----------------
Users should be fully aware of any hazards associated with the samples they are working with. Organic compounds may be highly flammable, corrosive, carcinogenic etc.

Getting Started
===============

Login into NMR facility computers
---------------------------------
If your NMR account has been created use your university NetID and password to login into any NMR facility computer, otherwise contact NMR facility personnel.

Prepare your sample
-------------------

.. image:: _static/sample.png
   :align: right
   :alt: sample

--------------------------------------
Inserting the Sample into the Spinner
--------------------------------------
The glass tube containing the sample to be analyzed is held in a plastic spinner. A sample depth gauge is provided to control the depth of the sample tube in the spinner. This is to ensure that the sample is correctly aligned with the coils inside the probe. The depth gauge has a graduated scale which can be used to set the depth of the sample. 
	
	1. Holding the sample by the top, place the sample tube in the spinner and the spinner in the depth gauge. 
	2. Gently push the sample tube down so that the depth of the sample above and below the center line is equal. If there is enough sample volume then push the sample down so that it just touches the white plastic  ase. It is recommended the sample height is 5-6 cm (~2 inches, volume ~0.6 ml).
	3. Remove the depth gauge before inserting the sample and spinner into the magnet.

--------------------------------------
Inserting the Sample into the Magnet
--------------------------------------


The sample in position 1 is the Standard CDCL3 sample. It must always remain there.
	**NEVER REMOVE THE SAMPLE FROM SLOT 1.**

To insert the sample with the spinner into the magnet use the following procedure:
	
	1. Place your sample in any free slot. Note what slot it is in.
	2. Un-LOCK the current sample and turn off rotation.
	3. Type the command ``isx x``. Where ‘*x*’ is the slot your sample is in, i.e., ``isx 6``. This will eject the current sample and load the sample in slot 6.
	4. The standard CDCl3 sample must be put back into the magnet when you finish your experiments before you logout. The standard must be locked and spinning.


----------------------
Locking the Sample
----------------------

1. Type the command ``lock``. This will display the solvent selection menu. 
2. Select the appropriate solvent from the menu and click OK. 
3. The system will begin to auto-lock.

.. image:: _static/lock.png
   :align: right
   :alt: lock
   :scale: 75

----------------------
Unlocking the Sample
----------------------
1. Type the command ``lock off``.  This turns off the lock.

----------------------
Spinning
----------------------
To start or stop spinning 
 * ``ro on`` turns on sample rotation.
 * ``ro off`` turns off sample rotation.

Shimming
---------
Shimming is a process in which minor adjustments are made to the magnetic field until the field homogeneity (uniformity) is optimized. Improving the homogeneity will result in better spectral resolution. It will be necessary to re-shim each time a sample is changed.  Routine shimming should be carried out at the beginning of every NMR session, and whenever the sample in the magnet is changed.  TOPSHIM will shim the sample automatically. Your sample must be spinning for this to work.

1. Type the command ``topshim`` to start automatic shimming.
2. The duration of 1D shimming will vary from several seconds up to a few minutes depending upon the available signal strength.
3. TopShim will finish after the optimal magnetic field homogeneity has been obtained.



Acquiring Data
===============
Any data set acquired with the spectrometer is automatically stored in what is called the “current” data set.

Before you acquire any new data, you should always create a new data set in which it can be stored. This will prevent you from overwriting existing data. The term “creating a new data set” may be a little misleading. Up to this point you have not yet acquired any data, however, by creating a new data set the computer prepares a set of files in which your data will be stored.

Create a New Data Set
------------------------
.. image:: _static/new_data.png
   :align: right
   :scale: 80

Each user has in his/her personal account, home directory /nmrdata/*netID*, two files **Setup-1H** and **Setup-13C** to set up measurements of 1D 1H and 13C spectra, respectively. Those files can be used to create new data set for measurement of respective spectra. For example, to create a new data set for measurement of 1H spectrum drag the Setup_H1 file from your folder into the spectrum display area.



Do the following after dragging in the *Setup_H1* file:
	Click Start → Create Dataset

1. Specify the dataset **name**, **expno**, and, **procno** in the appearing dialog box. If one or more datasets are open, the fields are initialized with the current dataset. There should be no spaces between letters/numbers in the name.
2. If you wish, type a comment in the *TITLE* box.
3. Click OK.
4. Once a new data set is created LEFT click on the |prosol| button.
5. The only parameter that must be set is the number of scans, **ns**, for example, ``ns 128``.

.. |prosol| image:: _static/prosol.png
	:scale: 50

.. |buttons| image:: _static/buttons.png
   :scale: 100


It is possible to check all acquisition and processing parameters by opening the Acquisition Parameters and Processing Parameters tabs, respectively. To view the acquisition parameters you can either type ``eda`` or click on the tab that says **AcquPars**. To display the processing parameters you can either type ``edp`` or click on the **ProcPars** tab.


Also, clicking on the pulse icon will show acquisition parameters only  applicable to the created experiment. This greatly simplifies experiment setup options. 

|buttons| 

------------------------------
Measurement of Proton spectra
------------------------------

This section describes the procedure to acquire a proton spectrum. The principal steps are:

1. Create a new data set, e.g. *hydrogen-11*.
2. LEFT click the set probe/solvent dependent parameters button. |prosol|
3. Insert the sample and start spinning. ``isx 8`` and ``ro on``
4. Lock the sample. ``lock``
5. Run Topshim. ``topshim``
6. Set number of scans, ns. How long the experiment will take can be checked by clicking the TIME button. ``ns 64``
7. Set the receiver gain with rga.  ``rga``
8. Enter zg to start the acquisition.  ``zg``
9. While experiment is running you may enter ``tr`` and to view your data type ``ft;apk``
10. Enter ``halt`` if data is good and you wish to stop the experiment.

----------------------------------------------
13C spectrum with broadband Proton decoupling
----------------------------------------------

This section describes the procedure to acquire a carbon spectrum. The principal steps are:

1. Establish a new data set, e.g. *C13_my-latest.reaction*.
2. LEFT click the (set prosol) button. |prosol|
3. Insert the sample and start spinning if not already done. ``isx 8`` and ``ro on``
4. Lock the sample if not already done. ``lock``
5. Run Topshim if not already done. ``topshim``
6. Set number of scans, ns. How long the experiment will take can be checked by clicking the TIME button. ``ns 128``
7. Tune the probe; enter the command ``atma``.
8. Set the receiver gain with rga.  ``rga``
9. Enter zg to start the acquisition. ``zg``
10. While experiment is running you may enter tr and to view your data type ``em;ft;apk``.
11. Enter halt if data is good. ``halt``


Processing
===============

.. image:: _static/process.png
   :align: center

Fourier Transformation
------------------------

A Fourier Transformation is used to convert the FID to a frequency spectrum. Before performing Fourier transformation one can also apply various weighting functions to the FID either to enhance resolution or S/N (signal to noise ratio) in the spectra using the ``em`` command. Fourier transformation is implemented using the ``ft`` command. Upon entering this command the display automatically returns to the main window containing the corresponding spectrum. If you wish to reenter the acquisition window, enter ``acqu``. The spectrum may appear distorted after the ``ft`` command, but this can be overcome using phase correction techniques described below.

Phase Correction
-------------------
Phase shifts of either the transmitted or received signal within the spectrometer hardware are inevitable and must be initially corrected for. The simplest procedure is automatic phase correction which is implemented using the command ``apk``.

Calibration of Spectrum (Referencing)
----------------------------------------

It is conventional in NMR spectroscopy to calibrate the spectrum by setting the TMS peak to 0ppm. Prior to calibration it may be useful to expand the spectrum horizontally in the region on either side of the TMS signal itself, as this will aid in pinpointing the exact position of the peak. If the sample does not contain TMS use a residual solvent signal for referencing. Chemical shift values for common solvents are shown in the table that is attached to the lab entry door.

--------------------------------------
Expand the Spectrum Horizontally
--------------------------------------

	1. Using the mouse position the cursor within the spectral window and click the left mouse button. It will automatically be tied to the spectrum. 
	2. Using the mouse position the cursor on one side of the region of interest and click and hold the left mouse button. 
	3. Using the mouse position the cursor on the other side of the region of interest and release the left mouse button. The defined region will be automatically expanded to fill the entire screen. 

--------------------------------------
Calibration Procedure
--------------------------------------

	1. Open the *Processing* tab.
	2. Click on *calibrate*. The cursor will be automatically tied to the spectrum. Move the mouse until the cursor is positioned on the TMS or solvent peak.
	3. Click the left mouse button, and when prompted for the cursor frequency in ppm, enter zero for TMS or the chemical shift value for the solvent you’re using.

An automatic calibration of the spectrum may also be achieved by entering the command ``sref`` if your sample has TMS. This procedure searches for a single peak around 0ppm, which may cause an error if your sample doesn’t contain TMS. This starts a procedure in which the software searches for a signal in the region of 0 ppm and automatically sets its value to exactly 0 ppm. For the sref procedure to work, the appropriate solvent must be chosen in the lock routine.

.. |integral| image:: _static/integral.png
	:scale: 75

.. |save| image:: _static/save.png

Integrating the spectrum
--------------------------

	1. Click on the **Process** tab, the **Integrate** button in the TopSpin Menu bar.
	2. Make sure the “Define new integral range” button is highlighted. |integral|
	3. Place the cursor downfield of the first peak of interest.
	4. Press the left mouse button and drag the mouse up-field of the peak of interest.
	5. Release the left mouse button to return.
	6. Repeat for each additional peak/region of interest.
	
	1. Place the cursor within the integral label of any peak you wish to calibrate and press the right mouse button.
	2. Select *calibrate*.
	3. Enter the desired value of the selected integral.
	4. Click on the floppy disk icon to save the integrals. 	|save|

.. |peak| image:: _static/peak.png

Peak Picking
--------------------------
Peak picking can be performed interactively in the peak picking mode.

	|peak|

	1. Click on the **Process** tab, the **Peak Pick** button in the TopSpin Menu bar. This puts you in a "Interactive Peak Pick" mode.
	2. Make sure the “Define new peak picking range” button is highlighted. 
	3. Press and hold the left mouse button over the peaks of interest. A green highlight will form.
	4. Release the left mouse button.
	5. Click on the floppy disk icon to save the peak pick. 	|save|

Plotting
----------
To Plot, or Print your spectra, enter the command ``prnt``. This will automatically print your spectra as displayed (what you see is what you get).
You may also use the commands below if you want to change the look of your plot.

	* ``plot`` will start the Plot Editor, the interactive program for viewing or designing plot layouts.
	* ``autoplot`` will plot data according to Plot Editor layout (1D,2D), with the current limits and scaling.
	* ``prnt`` will plot exactly what is in the spectra window of TopSpin (what you see is what you get).


Archiving Data
-----------------

	1. Enter the command ``wrpa``.  This will display the save data window.
	2. Change the directory to ``/home/NetID/afs/Private``. NetID is your individual Notre Dame NetID.

This will save your data to the AFS drive where you can access it via http://webfile.nd.edu, or other NMR workstations.
You may use NMR Facility workstations in room 136 NSH or 142 NSH to process your data free of charge using the same version of Topspin (Topspin 3.2 pl5) as it is on the spectrometer host computers.