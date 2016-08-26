/*
 * MATLAB Compiler: 4.7 (R2007b)
 * Date: Tue Dec 30 09:03:40 2008
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe" "-v"
 * "unite_pixels.m" 
 */

#include "mclmcr.h"

#ifdef __cplusplus
extern "C" {
#endif
const unsigned char __MCC_unite_pixels_session_key[] = {
    '0', 'E', '8', '5', 'F', '5', 'C', 'A', '6', 'F', 'C', '8', 'A', '2', '7',
    'A', '6', 'B', 'D', 'F', '6', 'F', '8', '2', 'D', 'C', '5', '3', '8', '8',
    '0', '6', 'E', 'D', 'B', '4', 'C', '3', '9', 'A', 'F', 'F', 'F', 'E', '9',
    '6', '4', '1', '3', '7', '4', 'D', 'F', 'B', 'E', '7', 'A', '8', '0', 'C',
    '7', '0', '1', '7', '3', '9', '8', '6', '9', '7', '7', '2', 'A', '8', 'E',
    'C', '8', '7', '6', '6', '3', '1', '3', 'C', 'E', 'D', '3', 'C', '3', 'A',
    'A', '0', '1', '6', '7', 'B', '8', '0', '9', '9', 'F', '7', '0', 'C', 'C',
    '5', 'F', '6', '0', 'C', '5', '4', 'A', 'F', 'C', '3', '3', '9', '9', 'E',
    '6', '4', 'C', '7', '3', '6', 'D', '9', '0', '5', 'F', '2', 'C', '9', '9',
    '8', 'C', 'B', '8', '4', '8', '9', 'F', 'E', '8', 'F', '1', '2', 'A', '8',
    'A', '4', 'A', '7', 'B', '4', 'F', 'D', '3', '1', '0', '8', '3', '6', 'A',
    'E', 'D', '4', 'E', '3', 'C', '6', 'A', '2', '6', 'D', '0', 'C', '8', '9',
    '4', 'F', 'A', '9', '4', 'B', '2', 'A', 'E', '8', 'E', '1', '6', '5', 'F',
    '3', '8', '0', '3', '9', 'A', 'B', '6', 'A', '5', 'F', 'E', 'B', '5', '4',
    'A', '4', 'E', 'C', 'C', '2', '6', 'B', 'E', 'E', '0', '3', 'B', '0', 'B',
    'B', 'A', 'E', 'B', '0', 'C', '6', '8', '5', 'D', 'B', '5', '7', '8', 'F',
    '8', '3', 'F', '0', '0', 'D', 'D', 'B', '4', 'F', 'D', 'E', 'C', 'C', 'D',
    'D', '\0'};

const unsigned char __MCC_unite_pixels_public_key[] = {
    '3', '0', '8', '1', '9', 'D', '3', '0', '0', 'D', '0', '6', '0', '9', '2',
    'A', '8', '6', '4', '8', '8', '6', 'F', '7', '0', 'D', '0', '1', '0', '1',
    '0', '1', '0', '5', '0', '0', '0', '3', '8', '1', '8', 'B', '0', '0', '3',
    '0', '8', '1', '8', '7', '0', '2', '8', '1', '8', '1', '0', '0', 'C', '4',
    '9', 'C', 'A', 'C', '3', '4', 'E', 'D', '1', '3', 'A', '5', '2', '0', '6',
    '5', '8', 'F', '6', 'F', '8', 'E', '0', '1', '3', '8', 'C', '4', '3', '1',
    '5', 'B', '4', '3', '1', '5', '2', '7', '7', 'E', 'D', '3', 'F', '7', 'D',
    'A', 'E', '5', '3', '0', '9', '9', 'D', 'B', '0', '8', 'E', 'E', '5', '8',
    '9', 'F', '8', '0', '4', 'D', '4', 'B', '9', '8', '1', '3', '2', '6', 'A',
    '5', '2', 'C', 'C', 'E', '4', '3', '8', '2', 'E', '9', 'F', '2', 'B', '4',
    'D', '0', '8', '5', 'E', 'B', '9', '5', '0', 'C', '7', 'A', 'B', '1', '2',
    'E', 'D', 'E', '2', 'D', '4', '1', '2', '9', '7', '8', '2', '0', 'E', '6',
    '3', '7', '7', 'A', '5', 'F', 'E', 'B', '5', '6', '8', '9', 'D', '4', 'E',
    '6', '0', '3', '2', 'F', '6', '0', 'C', '4', '3', '0', '7', '4', 'A', '0',
    '4', 'C', '2', '6', 'A', 'B', '7', '2', 'F', '5', '4', 'B', '5', '1', 'B',
    'B', '4', '6', '0', '5', '7', '8', '7', '8', '5', 'B', '1', '9', '9', '0',
    '1', '4', '3', '1', '4', 'A', '6', '5', 'F', '0', '9', '0', 'B', '6', '1',
    'F', 'C', '2', '0', '1', '6', '9', '4', '5', '3', 'B', '5', '8', 'F', 'C',
    '8', 'B', 'A', '4', '3', 'E', '6', '7', '7', '6', 'E', 'B', '7', 'E', 'C',
    'D', '3', '1', '7', '8', 'B', '5', '6', 'A', 'B', '0', 'F', 'A', '0', '6',
    'D', 'D', '6', '4', '9', '6', '7', 'C', 'B', '1', '4', '9', 'E', '5', '0',
    '2', '0', '1', '1', '1', '\0'};

static const char * MCC_unite_pixels_matlabpath_data[] = 
  { "unite_pixels/", "toolbox/compiler/deploy/",
    "$TOOLBOXMATLABDIR/general/", "$TOOLBOXMATLABDIR/ops/",
    "$TOOLBOXMATLABDIR/lang/", "$TOOLBOXMATLABDIR/elmat/",
    "$TOOLBOXMATLABDIR/elfun/", "$TOOLBOXMATLABDIR/specfun/",
    "$TOOLBOXMATLABDIR/matfun/", "$TOOLBOXMATLABDIR/datafun/",
    "$TOOLBOXMATLABDIR/polyfun/", "$TOOLBOXMATLABDIR/funfun/",
    "$TOOLBOXMATLABDIR/sparfun/", "$TOOLBOXMATLABDIR/scribe/",
    "$TOOLBOXMATLABDIR/graph2d/", "$TOOLBOXMATLABDIR/graph3d/",
    "$TOOLBOXMATLABDIR/specgraph/", "$TOOLBOXMATLABDIR/graphics/",
    "$TOOLBOXMATLABDIR/uitools/", "$TOOLBOXMATLABDIR/strfun/",
    "$TOOLBOXMATLABDIR/imagesci/", "$TOOLBOXMATLABDIR/iofun/",
    "$TOOLBOXMATLABDIR/audiovideo/", "$TOOLBOXMATLABDIR/timefun/",
    "$TOOLBOXMATLABDIR/datatypes/", "$TOOLBOXMATLABDIR/verctrl/",
    "$TOOLBOXMATLABDIR/codetools/", "$TOOLBOXMATLABDIR/helptools/",
    "$TOOLBOXMATLABDIR/demos/", "$TOOLBOXMATLABDIR/timeseries/",
    "$TOOLBOXMATLABDIR/hds/", "$TOOLBOXMATLABDIR/guide/",
    "$TOOLBOXMATLABDIR/plottools/", "toolbox/local/" };

static const char * MCC_unite_pixels_classpath_data[] = 
  { "" };

static const char * MCC_unite_pixels_libpath_data[] = 
  { "" };

static const char * MCC_unite_pixels_app_opts_data[] = 
  { "" };

static const char * MCC_unite_pixels_run_opts_data[] = 
  { "" };

static const char * MCC_unite_pixels_warning_state_data[] = 
  { "off:MATLAB:dispatcher:nameConflict" };


mclComponentData __MCC_unite_pixels_component_data = { 

  /* Public key data */
  __MCC_unite_pixels_public_key,

  /* Component name */
  "unite_pixels",

  /* Component Root */
  "",

  /* Application key data */
  __MCC_unite_pixels_session_key,

  /* Component's MATLAB Path */
  MCC_unite_pixels_matlabpath_data,

  /* Number of directories in the MATLAB Path */
  34,

  /* Component's Java class path */
  MCC_unite_pixels_classpath_data,
  /* Number of directories in the Java class path */
  0,

  /* Component's load library path (for extra shared libraries) */
  MCC_unite_pixels_libpath_data,
  /* Number of directories in the load library path */
  0,

  /* MCR instance-specific runtime options */
  MCC_unite_pixels_app_opts_data,
  /* Number of MCR instance-specific runtime options */
  0,

  /* MCR global runtime options */
  MCC_unite_pixels_run_opts_data,
  /* Number of MCR global runtime options */
  0,
  
  /* Component preferences directory */
  "unite_pixels_CC970B80143D08338C91191A6C740CE8",

  /* MCR warning status data */
  MCC_unite_pixels_warning_state_data,
  /* Number of MCR warning status modifiers */
  1,

  /* Path to component - evaluated at runtime */
  NULL

};

#ifdef __cplusplus
}
#endif


