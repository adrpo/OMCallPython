within OMCallPython;
package Examples

  import  OMCallPython.Py;

  model Test
    Py.PythonLibraryHandle pyHandle = Py.PythonLibraryHandle("e:/bin/py64/python38.dll");
  initial algorithm
    Py.initialize(pyHandle);
    Py.run(pyHandle, "import sys");
  equation
    Py.run(pyHandle, "print('Python says: simulation time'," + String(time) + ")\nsys.stdout.flush()");
  end Test;
end Examples;
