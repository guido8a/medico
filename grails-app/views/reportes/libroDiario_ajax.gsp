<%@ page import="sri.Contabilidad" %>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-2" style="font-weight: bold">
            Contabilidad
        </div>
        <div class="col-md-9">
            <g:select name="contabilidadDiario" id="contabilidadDiario" from="${sri.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                      optionKey="id" optionValue="descripcion" class="form-control"/>
        </div>
    </div>
    <div class="col-md-12" style="margin-top: 10px">
        <div class="col-md-2" style="font-weight: bold">
            Período
        </div>
        <div class="col-md-9" id="divPeriodo" >


        </div>
    </div>
</div>

<script type="text/javascript">

    $("#contabilidadDiario").change(function () {
        cargarPeriodo();
    });

    cargarPeriodo();

    function cargarPeriodo() {
        var contabilidad = $("#contabilidadDiario option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'periodo_ajax')}',
            data:{
                contabilidad: contabilidad
            },
            success: function (msg) {
                $("#divPeriodo").html(msg)
            }
        })
    }

</script>