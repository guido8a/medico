<div class="col-md-2 tamano bd" style="margin-top: 10px">
    Libretines:
</div>

<div class="col-md-3">
    <g:select name="libretines" from="${sri.DocumentoEmpresa.findAllByEstablecimiento(establecimiento)}" optionValue="${{"Libretín - " + it.fechaInicio.format("dd-MM-yyyy")}}" optionKey="id" class="form-control"/>
</div>

<div class="col-md-7" id="divFechasValidez">

</div>

<div class="col-md-12" id="divNumeracion" style="margin-top: 5px">

</div>


<script type="text/javascript">

    $("#libretines").change(function () {
        cargarFechasValidez();
        cargarNumeracion();
    });

    cargarFechasValidez();
    cargarNumeracion();

    function cargarFechasValidez() {
        var libretin = $("#libretines option:selected").val();
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'fechasValidez_ajax')}',
            data: {
                id: libretin
            },
            success: function (msg) {
                d.modal("hide");
                $("#divFechasValidez").html(msg)
            }
        })
    }

    function  cargarNumeracion() {
        var libretin = $("#libretines option:selected").val();
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'numeracionFactura_ajax')}',
            data: {
                id: libretin
            },
            success: function (msg) {
                d.modal("hide");
                $("#divNumeracion").html(msg)
            }
        })
    }

</script>