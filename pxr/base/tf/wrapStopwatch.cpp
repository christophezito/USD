//
// Copyright 2016 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//

#include "pxr/pxr.h"

#include "pxr/base/tf/stopwatch.h"

#include <boost/python/class.hpp>


using namespace boost::python;

PXR_NAMESPACE_USING_DIRECTIVE

void wrapStopwatch() {

    typedef TfStopwatch This;

    class_<This>("Stopwatch")

        .def("Start", &This::Start)
        .def("Stop", &This::Stop)
        .def("Reset", &This::Reset)
        .def("AddFrom", &This::AddFrom)

        .add_property("nanoseconds", &This::GetNanoseconds)
        .add_property("microseconds", &This::GetMicroseconds)
        .add_property("milliseconds", &This::GetMilliseconds)
        .add_property("sampleCount", &This::GetSampleCount)
        .add_property("seconds", &This::GetSeconds)
        ;
}
