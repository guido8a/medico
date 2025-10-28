<div class="row">
    <div class=col-md-12">

        <div class="col-md-2" style="font-weight: bold">
            Contabilidad
        </div>
        <div class="col-md-9">
            <g:select name="contCuentas" id="contCuentas" from="${sri.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                      optionKey="id" optionValue="descripcion" class="form-control"/>
        </div>
        <div class="col-md-12" style="margin-top: 5px">
            <div class="col-md-2" style="font-weight: bold">
                Desde
            </div>
            <div class="col-md-4">
                <input aria-label="" name="fechaDesde" id='fechaDesde' type='text' class="form-control required" required="" value="${new Date()?.format("dd-MM-yyyy")}" />
            </div>
        </div>
        <div class="col-md-12" style="margin-top: 5px">
            <div class="col-md-2" style="font-weight: bold">
                Hasta
            </div>
            <div class="col-md-4">
                <input aria-label="" name="fechaHasta" id='fechaHasta' type='text' class="form-control required" required="" value="${new Date()?.format("dd-MM-yyyy")}" />
            </div>
        </div>

        <div class="col-md-12" style="margin-top: 5px">
            <div class="col-md-2" style="font-weight: bold">
                <label class="uno">Cuenta:</label>
            </div>
            <g:hiddenField name="idCntaLibro" value="" />
            <div class="col-md-7">
                <g:textField name="cntaLibro" readonly="" value="" class="form-control required" />
            </div>
            <div class="col-md-2">
                <a href="#" class="link btn btn-info btn-ajax" id="buscarCuenta">
                    <i class="fa fa-search"></i> Buscar
                </a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    $('#fechaDesde,#fechaHasta').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        maxDate: new Date(),
        icons: {
        }
    });

    $("#buscarCuenta").click(function () {
        buscarCuentas();
    });


</script>