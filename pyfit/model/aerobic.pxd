cdef class Riegel:
    cdef readonly double d1
    cdef readonly double t1

    cpdef double distance(self, double t2)

    cpdef double time(self, double d2)

cdef class Cameron:
    cdef readonly double d1
    cdef readonly double t1

    cdef double __f__(self, double x)

    cpdef double time(self, double d2)

cdef class VV:
    cdef readonly double d1
    cdef readonly double t1

    cdef double adj_timer(self, double d1, double t1)

    cdef double riegel_velocity(self, double distance)

    cpdef double time(self, double mileage, double d2=*)
