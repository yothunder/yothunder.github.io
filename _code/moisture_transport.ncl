begin

    ; use function for calculate t and p-value
    undef ("signif")
    function signif(xavg, xvar, xn, yavg, yvar, yn)
    begin
        iflag           = False                     ; population variance similar
        tval_opt        = False                     ; p-value only
        prob            = ttest(xavg,xvar,xn,yavg,yvar,yn,iflag,tval_opt)

        pval            = (/prob/)
        pval@long_name  = "probability"
        copy_VarCoords(xavg,pval)
        diff            = xavg - yavg
        diff@long_name  = "difference of the means"
        copy_VarCoords(xavg,diff)

        return ([/ xavg, diff, pval /])
    end

    ;;------------------------------------------------------------------------------------------:
    ;                                         MAIN CODE
    ;;------------------------------------------------------------------------------------------:

    ; input data

    xncs   = 32 ; number of CS days
    xncens = 31 ; number of CENS days
    yn     = 53 ; monthly average (nov-mar, 2010-2019)  
    pathin = "../data/#/"

    ;---iuq_ivq : integrated moisture flux (zonal & meridional)

    xiuqcsavg    = fmb1cs->iuqcsmean(:,:,:)
    xiuqcsvar    = fmb1cs->iuqcsvari(:,:,:)
    xivqcsavg    = fmb1cs->ivqcsmean(:,:,:)
    xivqcsvar    = fmb1cs->ivqcsvari(:,:,:)

    xiuqcensavg  = fmb1cens->iuqcensmean(:,:,:)
    xiuqcensvar  = fmb1cens->iuqcensvari(:,:,:)
    xivqcensavg  = fmb1cens->ivqcensmean(:,:,:)
    xivqcensvar  = fmb1cens->ivqcensvari(:,:,:)

    yiuqavg_     = dim_avg_n(fmb2->iuq(:,:,:),0)
    yiuqvar_     = dim_variance_n(fmb2->iuq(:,:,:),0)
    yivqavg_     = dim_avg_n(fmb2->ivq(:,:,:),0)
    yivqvar_     = dim_variance_n(fmb2->ivq(:,:,:),0)

    yiuqavg      = new((/21, 141, 121/), typeof(yiuqavg_), yiuqavg_@_FillValue)
    yiuqvar      = new((/21, 141, 121/), typeof(yiuqavg_), yiuqavg_@_FillValue)
    yivqavg      = new((/21, 141, 121/), typeof(yiuqavg_), yiuqavg_@_FillValue)
    yivqvar      = new((/21, 141, 121/), typeof(yiuqavg_), yiuqavg_@_FillValue)

    printMinMax(xiuqcsavg,0)
    print("xiuqcsvar")
    printMinMax(xiuqcsvar,0)
    printMinMax(xivqcsavg,0)
    print("xivqcsvar")
    printMinMax(xivqcsvar,0)
    printMinMax(xiuqcensavg,0)
    print("xiuqcensvar")
    printMinMax(xiuqcensvar,0)
    printMinMax(xivqcensavg,0)
    print("xivqcensvar")
    printMinMax(xivqcensvar,0)
    print(" ")

    do i=0, 20
        yiuqavg(0:0,:,:) = (/yiuqavg_/)
        yiuqvar(0:0,:,:) = (/yiuqvar_/)
        yivqavg(0:0,:,:) = (/yivqavg_/)
        yivqvar(0:0,:,:) = (/yivqvar_/)

        yiuqavg_        := yiuqavg(0:0,:,:)
        yiuqvar_        := yiuqvar(0:0,:,:)
        yivqavg_        := yivqavg(0:0,:,:)
        yivqvar_        := yivqvar(0:0,:,:)

        yiuqavg(i,:,:)   = yiuqavg_
        yiuqvar(i,:,:)   = yiuqvar_
        yivqavg(i,:,:)   = yivqavg_
        yivqvar(i,:,:)   = yivqvar_
    end do

;---{del}.[iuq, ivq] : Vertically Integrated Moisture flux divergence

    xvimfdcsavg     = fmb1cs->vimfdcsmean(:,:,:)
    xvimfdcsvar     = fmb1cs->vimfdcsvari(:,:,:)

    xvimfdcensavg   = fmb1cens->vimfdcensmean(:,:,:)
    xvimfdcensvar   = fmb1cens->vimfdcensvari(:,:,:)

    yvimfdavg_      = dim_avg_n(fmb2->vimfd(:,:,:),0)
    yvimfdvar_      = dim_variance_n(fmb2->vimfd(:,:,:),0)

    printMinMax(xvimfdcsavg,0)
    printMinMax(xvimfdcsvar,0)
    printMinMax(xvimfdcensavg,0)
    printMinMax(xvimfdcensvar,0)
    printMinMax(yvimfdavg_,0)
    printMinMax(yvimfdvar_,0)

    yvimfdavg       = new((/21, 141, 121/), typeof(yvimfdavg_), yvimfdavg_@_FillValue)
    yvimfdvar       = new((/21, 141, 121/), typeof(yvimfdavg_), yvimfdavg_@_FillValue)

    ;printVarSummary(yvimfdavg_)
    ;printVarSummary(yvimfdavg)

    do i=0, 20
        yvimfdavg(0:0,:,:)  = (/yvimfdavg_/)
        yvimfdvar(0:0,:,:)  = (/yvimfdvar_/)

        yvimfdavg_         := yvimfdavg(0:0,:,:)
        yvimfdvar_         := yvimfdvar(0:0,:,:)

        yvimfdavg(i,:,:)    = yvimfdavg_
        yvimfdvar(i,:,:)    = yvimfdvar_
    end do

    ;---Calculate significance

    ;--iuq_ivq
    print("SIGNIF IUQ_IVQ")
    iuqcs      = signif(xiuqcsavg,xiuqcsvar,xncs,yiuqavg,yiuqvar,yn)
    ivqcs      = signif(xivqcsavg,xivqcsvar,xncs,yivqavg,yivqvar,yn)
    iuqcens    = signif(xiuqcensavg,xiuqcensvar,xncens,yiuqavg,yiuqvar,yn)
    ivqcens    = signif(xivqcensavg,xivqcensvar,xncens,yivqavg,yivqvar,yn)

    ;--{del}.[iuq, ivq]
    print("SIGNIF VIMFD")
    vimfdcs      = signif(xvimfdcsavg,xvimfdcsvar,xncs,yvimfdavg,yvimfdvar,yn)
    vimfdcens    = signif(xvimfdcensavg,xvimfdcensvar,xncens,yvimfdavg,yvimfdvar,yn)

    ;printVarSummary(iuqcs[0])
    ;printVarSummary(iuqcs[1])
    ;printVarSummary(iuqcs[2])
    ;printVarSummary(ivqcs[0])
    ;printVarSummary(ivqcs[1])
    ;printVarSummary(ivqcs[2])

    ;===========================================================================================;
    ;                                       Write NetCDF
    ;===========================================================================================;

    diro                = "./"
    filo                = "moisture_transport.nc"
    ptho                = diro+filo
    system("/bin/rm -f "+ptho)
    ncdf                = addfile(ptho,"c")

    fAtt = True
    fAtt@title          = "moisture transport - CS/CENS"
    fAtt@source         = "ECMWF"
    fAtt@Conventions    = "None"
    fAtt@creation_date  = systemfunc("date")
    fileattdef(ncdf,fAtt)             ; copy file attributes
    
    filedimdef(ncdf,"timelag",-1,True)   ; make time an UNLIMITED dimension

    ncdf->iuqcsmean   = iuqcs[0]
    ncdf->iuqcsdiff   = iuqcs[1]
    ncdf->iuqcspval   = iuqcs[2]
    ncdf->iuqcensmean = iuqcens[0]
    ncdf->iuqcensdiff = iuqcens[1]
    ncdf->iuqcenspval = iuqcens[2]

    ncdf->ivqcsmean   = ivqcs[0]
    ncdf->ivqcsdiff   = ivqcs[1]
    ncdf->ivqcspval   = ivqcs[2]
    ncdf->ivqcensmean = ivqcens[0]
    ncdf->ivqcensdiff = ivqcens[1]
    ncdf->ivqcenspval = ivqcens[2]
    
    ncdf->vimfdcsmean   = vimfdcs[0]
    ncdf->vimfdcsdiff   = vimfdcs[1]
    ncdf->vimfdcspval   = vimfdcs[2]
    ncdf->vimfdcensmean = vimfdcens[0]
    ncdf->vimfdcensdiff = vimfdcens[1]
    ncdf->vimfdcenspval = vimfdcens[2]

end
