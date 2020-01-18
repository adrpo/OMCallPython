
#if !defined(__OMCallPython_H__)
#define __OMCallPython_H__


#if defined WIN32
  #include <windows.h>
  #define omcPyLibTy HINSTANCE
  #define AddressOf GetProcAddress
  #define freeDLL FreeLibrary
#else
  #include <dlfcn.h>
  #define omcPyLibTy void*
  #define AddressOf dlsym
  #define freeDLL dlclose
#endif

static omcPyLibTy omc_PythonDLL = NULL;

#include <stdio.h>
#include <Python.h> /* assume Python.h is in $MODELICAUSERCFLAGS which points to the place where Python.h is via -I/path/to/python/include/ */

typedef char* (*fnptr_omc_Py_Initialize)();
static fnptr_omc_Py_Initialize omc_Py_Initialize = NULL;

typedef int (*fnptr_omc_PyRun_SimpleString)(const char*);
static fnptr_omc_PyRun_SimpleString omc_PyRun_SimpleString = NULL;

typedef int (*fnptr_omc_Py_Finalize)();
static fnptr_omc_Py_Finalize omc_Py_Finalize = NULL;

static int resolveFunctionNames()
{
  omc_Py_Initialize = (fnptr_omc_Py_Initialize)AddressOf(omc_PythonDLL, "Py_Initialize");
  omc_PyRun_SimpleString = (fnptr_omc_PyRun_SimpleString)AddressOf(omc_PythonDLL, "PyRun_SimpleString");
  omc_Py_Finalize = (fnptr_omc_Py_Finalize)AddressOf(omc_PythonDLL, "omc_Py_Finalize");
  return 0;
}

static omcPyLibTy omc_PyLibLoad(const char* pyLibPath)
{
  // check for omc_PythonDLL instance for the first time this function called and load the library
  if(!omc_PythonDLL)
  {
    #if defined WIN32
      omc_PythonDLL = LoadLibrary(pyLibPath);
    #else
      omc_PythonDLL = dlopen(pyLibPath, RTLD_LAZY);
    #endif
    if(!omc_PythonDLL)
    {
      printf("Could not load the dynamic library %s Exiting the program\n", pyLibPath);
      exit(0);
    }
    // resolve function signatures one time during initialization
    resolveFunctionNames();
  }
  return omc_PythonDLL;
}

static void omc_PyLibFree(void* pyHandle)
{
  if(!omc_PythonDLL)
  {
    printf("Python instance is not found, Please load the Python instance using omc_PyLibLoad()\n");
    exit(0);
  }
  freeDLL(omc_PythonDLL);
}


#endif /* #if !defined(__OMCallPython_H__) */