within OMCallPython;
package Examples

  import  OMCallPython.Py;

  model Test
    Py.PythonLibraryHandle pyHandle = Py.PythonLibraryHandle("e:/bin/python64/python27.dll");
  initial equation
    Py.initialize(pyHandle);
  equation
    Py.run(pyHandle, "print 'Python says: simulation time'," + String(time) + "\n");
  end Test;
end Examples;
