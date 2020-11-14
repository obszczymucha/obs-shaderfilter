project(obs-shaderfilter VERSION 1.21.0)
set(PROJECT_FULL_NAME "OBS Shaderfilter")

set(obs-shaderfilter_SOURCES
	obs-shaderfilter.c)

if(WIN32)
	get_filename_component(ISS_FILES_DIR "${CMAKE_BINARY_DIR}\\..\\package" ABSOLUTE)
	file(TO_NATIVE_PATH "${ISS_FILES_DIR}" ISS_FILES_DIR)
	get_filename_component(ISS_PACKAGE_DIR "${CMAKE_PACKAGE_PREFIX}\\.." ABSOLUTE)
	file(TO_NATIVE_PATH "${ISS_PACKAGE_DIR}" ISS_PACKAGE_DIR)
	get_filename_component(ISS_SOURCE_DIR "${PROJECT_SOURCE_DIR}" ABSOLUTE)
	file(TO_NATIVE_PATH "${ISS_SOURCE_DIR}" ISS_SOURCE_DIR)
	configure_file("installer.iss.in"
			"${PROJECT_BINARY_DIR}/installer.iss"
		)
	configure_file(resource.rc.in obs-shaderfilter.rc)
	list(APPEND obs-shaderfilter_SOURCES
		obs-shaderfilter.rc)
endif()

add_library(obs-shaderfilter MODULE
	${obs-shaderfilter_SOURCES})
target_link_libraries(obs-shaderfilter
	libobs)

set_target_properties(obs-shaderfilter PROPERTIES FOLDER "plugins/exeldro")
install_obs_plugin_with_data(obs-shaderfilter data)
