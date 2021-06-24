
The design files are located at
C:/Users/Administrator/Desktop/xusp3s_mig/SoftMC-master/hw/boards/ML605/ipcore_dir:

   - xilinx_mig.veo:
        veo template file containing code that can be used as a model
        for instantiating a CORE Generator module in a HDL design.

   - xilinx_mig.xco:
       CORE Generator input file containing the parameters used to
       regenerate a core.

   - xilinx_mig_flist.txt:
        Text file listing all of the output files produced when a customized
        core was generated in the CORE Generator.

   - xilinx_mig_readme.txt:
        Text file indicating the files generated and how they are used.

   - xilinx_mig_xmdf.tcl:
        ISE Project Navigator interface file. ISE uses this file to determine
        how the files output by CORE Generator for the core can be integrated
        into your ISE project.

   - xilinx_mig.gise and xilinx_mig.xise:
        ISE Project Navigator support files. These are generated files and
        should not be edited directly.

   - xilinx_mig directory.

In the xilinx_mig directory, three folders are created:
   - docs:
        This folder contains Virtex-6 FPGA Memory Interface Solutions user guide
        and data sheet.

   - example_design:
        This folder includes the design with synthesizable test bench.

   - user_design:
        This folder includes the design without test bench modules.

The example_design and user_design folders contain several other folders
and files. All these output folders are discussed in more detail in
Virtex-6 FPGA Memory Interface Solutions User Guide (UG406) located
in docs folder.
    