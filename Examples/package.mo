within OMCallPython;
package Examples

  import OMCallPython.Py;

  model Test
    package ConfiguredPy = Py(PyIncludePath = "E:/bin/py64/include", PyDll = "E:/bin/py64/python3.dll");
    ConfiguredPy.PythonLibraryHandle pyHandle = ConfiguredPy.PythonLibraryHandle();
  initial equation
    ConfiguredPy.initialize(pyHandle);
  equation
    ConfiguredPy.run(pyHandle, "print 'Python says: simulation time'," + String(time) + "\n");
  end Test;
end Examples;
