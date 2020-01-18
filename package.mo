package OMCallPython
  package Py
    constant String PyHome = "";
    constant String PyIncludePath = PyHome + "/include/";
    constant String PyDll = PyHome + "/python.dll";

    class PythonLibraryHandle
      extends ExternalObject;

      function constructor "External object constructor that loads the python dll"
        input String pyLibPath = PyDll;
        output PythonLibraryHandle pyHandle;

        external "C" pyHandle = omc_PyLibLoad(pyLibPath) annotation (
          IncludeDirectory = "modelica://OMCallPython/Resources/C-Sources",
          Include = "#include \"OMCallPython.h\"");
      end constructor;

      function destructor "External object destructor that frees the python dll"
        input PythonLibraryHandle pyHandle;

        external "C" omc_PyLibFree(pyHandle) annotation (
          IncludeDirectory = "modelica://OMCallPython/Resources/C-Sources",
          Include = "#include \"OMCallPython.h\"");
      end destructor;
    end PythonLibraryHandle;

    function initialize
      input PythonLibraryHandle pyHandle;

      external "C" omc_Py_Initialize() annotation (
        IncludeDirectory = "modelica://OMCallPython/Resources/C-Sources",
        Include = "#include \"OMCallPython.h\"");
    end initialize;

    function run
      input PythonLibraryHandle pyHandle;
      input String pyProgram;

      external "C" omc_PyRun_SimpleString(pyProgram) annotation (
        IncludeDirectory = "modelica://OMCallPython/Resources/C-Sources",
        Include = "#include \"OMCallPython.h\"");
    end run;

    function finalize
      input PythonLibraryHandle pyHandle;

      external "C" omc_Py_Finalize() annotation (
        IncludeDirectory = "modelica://OMCallPython/Resources/C-Sources",
        Include = "#include \"OMCallPython.h\"");
    end finalize;
  end Py;
end OMCallPython;
