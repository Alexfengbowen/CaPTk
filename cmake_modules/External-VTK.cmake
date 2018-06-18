#MESSAGE( "External project - VTK" )

SET( VTK_DEPENDENCIES )

ExternalProject_Add( 
  VTK
  URL https://github.com/Kitware/VTK/archive/v8.1.0.zip
  #GIT_REPOSITORY ${git_protocol}://github.com/Kitware/VTK.git
  #GIT_TAG v8.1.0
  SOURCE_DIR VTK-source
  BINARY_DIR VTK-build
  UPDATE_COMMAND ""
  #PATCH_COMMAND "git apply --whitespace=nowarn ${CMAKE_CURRENT_BINARY_DIR}/vtk.patch"
  CMAKE_GENERATOR ${gen}
  #INSTALL_COMMAND ""
  CMAKE_ARGS
    ${ep_common_args}
    #-DCMAKE_CONFIGURATION_TYPES=${CMAKE_CONFIGURATION_TYPES}
    -DExternalData_OBJECT_STORES:STRING=${ExternalData_OBJECT_STORES}
    -DBUILD_EXAMPLES:BOOL=OFF # examples are not needed
    -DBUILD_SHARED_LIBS:BOOL=OFF # no static builds
    -DBUILD_TESTING:BOOL=OFF 
    -DVTK_Group_Qt:BOOL=ON # [QT] dependency, enables better GUI
    -DCMAKE_CXX_MP_FLAG=ON 
    -DVTK_Group_Imaging=ON 
    -DModule_vtkGUISupportQt:BOOL=ON 
    -DModule_vtkGUISupportQtOpenGL:BOOL=ON 
    -DModule_vtkRenderingQt:BOOL=ON 
    -DModule_vtkViewsQt:BOOL=ON
    -DVTK_USE_QTCHARTS:BOOL=ON
    -DVTK_USE_QVTK_QTOPENGL:BOOL=ON    
    -DCMAKE_DEBUG_POSTFIX:STRING=d
    -DVTK_QT_VERSION:STRING=5
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX:STRING=${CMAKE_BINARY_DIR}/install
)

SET( VTK_DIR ${CMAKE_BINARY_DIR}/VTK-build )
