
%{--<table class="table table-condensed table-hover table-striped table-bordered">--}%
%{--    <thead>--}%
%{--    <tr>--}%
%{--        <th style="width: 10%">Número</th>--}%
%{--        <th style="width: 45%">Fecha Desde</th>--}%
%{--        <th style="width: 45%">Fecha Hasta</th>--}%
%{--    </tr>--}%
%{--    </thead>--}%
%{--</table>--}%

<div class=""  style="width: 99.7%;height: 350px; overflow-y: auto;float: right; margin-top: -20px">
    <table id="tablaB" class="table-bordered table-condensed table-hover table-striped" style="width: 100%">
        <tbody>
        <g:each status="i" in="${periodos}" var="periodo" >
            <tr style="text-align: center; width: 100%" data-id="${periodo?.id}" >
                <td style="width: 20%">${periodo?.numero}</td>
                <td style="width: 30%">${periodo?.fechaInicio?.format("dd-MM-yyyy")}</td>
                <td style="width: 30%">${periodo?.fechaFin?.format("dd-MM-yyyy")}</td>
                <td style="width: 20%">
                    <a href="#" data-id="${periodo.id}" class="btn btn-success btn-xs btnEditarPeriodo btn-ajax" title="Editar">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="#" data-id="${periodo.id}" class="btn btn-danger btn-xs btnBorrarPeriodo btn-ajax" title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

   $(".btnEditarPeriodo").click(function (){
       var id = $(this).data("id");
       createEditPeriodo(id)
   });

   $(".btnBorrarPeriodo").click(function (){
       var id = $(this).data("id");
       borrarPeriodo(id)
   });

</script>