# Mutation Cover with Yosys (MCY) for Symbolic Quick Error Detection (SQED)

[MCY](https://github.com/YosysHQ/mcy.git) is a framework for performing mutation testing on hardware designs and helps to improve the quality of the testbench. It is integrated with [SymbiYosys (SBY)](https://symbiyosys.readthedocs.io/en/latest/) and can be used to evaluate hardware formal verification methods.  

[SQED](https://github.com/upscale-project/generic-sqed-demo.git) is a transformative processors and hardware accelerators formal verification methodology that can check a design-independent universal property, reducing manual property development efforts. SQED employs bounded model checking (BMC) to formally verify the self-consistency property, which asserts that the execution of an original instruction and its duplicate produces the consistent outcome.   


## Getting Started

#### Installing Tabby CAD Suite or OSS CAD Suite

For the information about Tabby CAD Suite and OSS CAD Suite, please refer to the links [https://www.yosyshq.com/tabby-cad-datasheet](https://www.yosyshq.com/tabby-cad-datasheet).

#### Running the example

```
# remove all old files produced by MCY, i.e. it deletes the database/ and tasks/ directories.
mcy purge 

# initialize the mcy database.
mcy init 

# execute the tests in the queue and any tests subsequently queued based on the results.
mcy run -j10 

# open the provided address in your browser to follow progress in the dashboard. This can be especially of interest when running tests on a remote server.
mcy dash 
```
