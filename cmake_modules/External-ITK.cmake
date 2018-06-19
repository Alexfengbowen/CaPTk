## Superbuild module for building ITK externally.

#MESSAGE( "External project - ITK" )

SET( ITK_DEPENDENCIES )

SET( ITK_DEPENDS VTK OpenCV )

IF( WIN32 )
  SET( EXTRA_WINDOWS_OPTIONS -DDCMTK_DIR:STRING=${DCMTK_DIR} -DITK_USE_SYSTEM_DCMTK:BOOL=ON )
  SET( ITK_DEPENDS ${ITK_DEPENDS} DCMTK )
ENDIF()

IF(UNIX)
  
  #MESSAGE( STATUS "flags: ${CMAKE_CXX_FLAGS}")
  
  #SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -ftemplate-depth=900 -fdiagnostics-color=always" )
ENDIF(UNIX) 


ExternalProject_Add( 
  ITK
  DEPENDS ${ITK_DEPENDS}
  URL https://github.com/InsightSoftwareConsortium/ITK/archive/v4.13.0.zip
  #GIT_REPOSITORY ${git_protocol}://itk.org/ITK.git #  url from where to download
  #GIT_TAG v4.13.0
  SOURCE_DIR ITK-source
  BINARY_DIR ITK-build
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  #INSTALL_COMMAND ""
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    ${ep_common_args}   
    #-DCMAKE_CONFIGURATION_TYPES=${CMAKE_CONFIGURATION_TYPES}
    -DBUILD_EXAMPLES:BOOL=OFF # examples are not needed
    -DBUILD_SHARED_LIBS:BOOL=OFF 
    -DBUILD_TESTING:BOOL=OFF # testing the ITK build is not required
    -DITK_BUILD_ALL_MODULES:BOOL=ON
    -DITK_DYNAMIC_LOADING:BOOL=OFF
    -DModule_ITKReview:BOOL=ON
    -DModule_LesionSizingToolkit:BOOL=ON
    -DModule_SkullStrip:BOOL=ON
    -DModule_TextureFeatures:BOOL=ON
    -DModule_RLEImage:BOOL=ON
    -DModule_IsotropicWavelets:BOOL=ON
    -DModule_PrincipalComponentsAnalysis:BOOL=ON
    -DVCL_INCLUDE_CXX_0X:BOOL=ON
    -DModule_ITKIODCMTK:BOOL=ON
    -DVCL_INCLUDE_CXX_0X:BOOL=ON
    -DDCMTK_USE_ICU:BOOL=OFF
    -DCMAKE_DEBUG_POSTFIX:STRING=d
    ${EXTRA_WINDOWS_OPTIONS}
    #-DITK_LEGACY_REMOVE:BOOL=ON 
    -DModule_ITKVideoBridgeOpenCV:BOOL=ON # [OPENCV] dependency
    -DOpenCV_DIR:PATH=${OpenCV_DIR} # [OPENCV] dependency
    -DModule_ITKVtkGlue:BOOL=ON # [VTK] dependency
    -DVTK_DIR:PATH=${VTK_DIR} # [VTK] dependency
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} # toggle for type of build if something different that 
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}/install
)

SET( ITK_DIR ${CMAKE_BINARY_DIR}/ITK-build )
