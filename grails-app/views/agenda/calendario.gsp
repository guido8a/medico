<div class="row">

    <div class="col-md-12 breadcrumb" style="text-align: center; font-size: 14px; font-weight: bold">
        Se muestran las citas agendadas en sus respectivos días con fondo <div class="demo vacacion" style="vertical-align: central;"></div> <br/>
    </div>

    <div class="col-md-12" style="font-weight: bold; margin-bottom: 50px">
        <div class="col-md-4"></div>
        <div class="col-md-1" style="font-size: 14px">Año</div>
        <div class="col-md-3"><g:select style="font-size:large;" name="anio" class="form-control"   from="${anio - 5..anio + 5}" value="${params.anio}"/>
        </div>
    </div>

    <div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px" id="divCalendario">

    </div>
</div>

<script type="application/javascript">

    cargarTablaCalendario_ajax();

    $("#anio").change(function () {
        cargarTablaCalendario_ajax();
    });

    function cargarTablaCalendario_ajax(){
        var anio = $("#anio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'agenda', action: 'tablaCalendario_ajax')}',
            data:{
                paciente: '${paciente?.id}',
                anio: anio
            },
            success: function (msg) {
                $("#divCalendario").html(msg)
            }
        });


        %{--if ("" + anio !== "${params.anio}") {--}%
        %{--    var v = cargarLoader("Guardando...");--}%
        %{--    location.href = "${createLink(action: 'calendario')}?paciente=" + '${paciente?.id}' + "&anio=" + anio;--}%
        %{--    v.modal("hide");--}%
        %{--}--}%
        %{--return false;--}%
    }

</script>