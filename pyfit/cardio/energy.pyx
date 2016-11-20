from pyfit.enums import PAL, Gender

cdef class BMREstimator(object):

    def __cinit__(self, int gender):
        self.gender = gender

    cdef double predict(self, double age, double weight, double height):
        raise NotImplementedError("The prediction method is not implemented")

cdef class HB(BMREstimator):

    cpdef double predict(self, double age, double weight, double height):
        if self.gender == Gender.Female:
            return (9.5634*weight)+(1.8496*height)-(4.6756*age)+655.0955
        return (13.7516*weight)+(5.0033*height)-(6.7550*age)+66.4730

cdef class RevisedHB(BMREstimator):

    cpdef double predict(self, double age, double weight, double height):
        if self.gender == Gender.Female:
            return (9.5634*weight)+(1.8496*height)-(4.6756*age)+655.0955
        return (13.7516*weight)+(5.0033*height)-(6.7550*age)+66.4730

cdef class MSJ(BMREstimator):

    cpdef double predict(self, double age, double weight, double height):
        if self.gender == Gender.Female:
            return (9.99 * weight + 6.25 * height - 4.92 * age - 161)
        return (9.99 * weight + 6.25 * height - 4.92 * age + 5)

cdef class RMR(object):

    def __cinit__(self, int gender, double age, double weight, double height):
        self.gender = gender
        self.age = age
        self.weight = weight
        self.height = height

    cpdef double quick(self):
        if self.gender == Gender.Female:
            return self.weight * 22
        return self.weight * 24.2

    cpdef double bsa(self, double bsa):
        if self.gender == Gender.Female:
            return bsa * 840
        return bsa * 912

cpdef double kma(double lbm):
    return 370 + (21.6 * lbm)


cpdef double cunningham(double lbm):
    return 500 + (22 * lbm)

cdef class TEEEstimator(object):

    def __cinit__(self, int gender, int pal):
        self.gender = gender
        self.pal = pal

    cdef double predict(self, double age, double weight, double height):
        raise NotImplementedError("The prediction method is not implemented")

    cpdef double fromActivity(self, double weight, double mets):
        return (mets * 3.5 * weight)/200

cdef class ChildTEE(TEEEstimator):

    cpdef double predict(self, double age, double weight, double height):
        if self.pal == PAL.Sedentary and self.gender == Gender.Male:
            return 88.5 - (61.9 * age) + 1*((26.7*weight)+(903*height))
        elif self.pal == PAL.Sedentary and self.gender == Gender.Female:
            return 135.3 - (30.8 * age) + 1*((10*weight)+(934*height))
        elif self.pal == PAL.Low and self.gender == Gender.Male:
            return 88.5 - (61.9 * age) + 1.13*((26.7*weight)+(903*height))
        elif self.pal == PAL.Low and self.gender == Gender.Female:
            return 135.3 - (30.8 * age) + 1.16*((10*weight)+(934*height))
        elif self.pal == PAL.Active and self.gender == Gender.Male:
            return 88.5 - (61.9 * age) + 1.26*((26.7*weight)+(903*height))
        elif self.pal == PAL.Active and self.gender == Gender.Female:
            return 135.3 - (30.8 * age) + 1.31*((10*weight)+(934*height))
        elif self.pal == PAL.VeryActive and self.gender == Gender.Male:
            return 88.5 - (61.9 * age) + 1.42*((26.7* weight)+(903* height))
        elif self.pal == PAL.VeryActive and self.gender == Gender.Female:
            return 135.3 - (30.8 * age) + 1.56*((10*weight)+(934*height))
        return 0

cdef class AdultTEE(TEEEstimator):

    cpdef double predict(self, double age, double weight, double height):
        if self.pal == PAL.Sedentary and self.gender == Gender.Male:
            return 662 - (9.53 * age) + 1*((15.9 * weight) + (540 * height))
        elif self.pal == PAL.Sedentary and self.gender == Gender.Female:
            return 354 - (6.91 * age) + 1*((9.36*weight)+(726*height))
        elif self.pal == PAL.Low and self.gender == Gender.Male:
            return 662 - (9.53 * age) + 1.11*((15.9*weight)+(540*height))
        elif self.pal == PAL.Low and self.gender == Gender.Female:
            return 662 - (9.53 * age) + 1.12*((15.9*weight)+(540*height))
        elif self.pal == PAL.Active and self.gender == Gender.Male:
            return 662 - (9.53 * age) + 1.25*((15.9*weight)+(540*height))
        elif self.pal == PAL.Active and self.gender == Gender.Female:
            return 662 - (9.53 * age) + 1.27*((15.9*weight)+(540*height))
        elif self.pal == PAL.VeryActive and self.gender == Gender.Male:
            return 662 - (9.53 * age) + 1.48*((15.9*weight)+(540*height))
        elif self.pal == PAL.VeryActive and self.gender == Gender.Female:
            return 662 - (9.53 * age) + 1.45*((15.9*weight)+(540*height))
        return 0
