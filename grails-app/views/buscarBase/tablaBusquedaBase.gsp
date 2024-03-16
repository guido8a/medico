<util:renderHTML html="${msg}"/>
<asset:stylesheet src="/apli/lzm.context-0.5.css"/>
<asset:javascript src="/apli/lzm.context-0.5.js"/>

<style type="text/css">
/*table {*/
/*    table-layout: fixed;*/
/*    overflow-x: scroll;*/
/*}*/
/*th, td {*/
/*    overflow: hidden;*/
/*    text-overflow: ellipsis;*/
/*    word-wrap: break-word;*/
/*}*/
</style>

<g:set var="clase" value="${'principal'}"/>

<div class=""  style="width: 99.7%;height: ${msg == '' ? 400 : 585}px; overflow-y: auto; margin-top: -20px">
    <table id="" class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:if test="${bases}">
            <g:each in="${bases}" var="dato" status="z">
                <tr id="${dato.id}" data-id="${dato.id}" class="${clase}">
                    <td style="width: 15%">
                        ${dato?.subtema?.tema?.nombre}
                    </td>

                    <td style="color:#186063; width: 25%">
                        ${dato?.subtema?.nombre}
                    </td>

                    <td style="width: 25%">
                        ${dato.problema}
                    </td>

                    <td style="width: 25%" class="text-info">
                        ${dato.solucion}
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a href="#" class="btn btn-xs btn-info btnVer" data-id="${dato.id}" title="Ver">
                            <i class="fas fa-search-plus"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-success btnEditar" data-id="${dato.id}" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-danger" style="text-align: center; font-weight: bold; width: 100%">
                <i class="fa fa-exclamation-circle fa-2x text-danger"></i> No existen resultados para su búsqueda
            </div>
        </g:else>
    </table>
</div>


<script type="text/javascript">


    $(".btnVer").click(function () {
        var id = $(this).data("id");
        $("#dialog-body").html(spinner);
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'base', action: 'show_ajax')}',
            data: {
                id: id,
                archivos: 0
            },
            success: function (msg) {
                $("#dialog-body").html(msg)
            }
        });
        $("#dialog").modal("show");
    });

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        location.href = '${createLink(controller: 'base', action: 'base')}/' + id
    })


    // $(function () {
    //     $("tr").contextMenu({
    //         items  : createContextMenu,
    //         onShow : function ($element) {
    //             $element.addClass("trHighlight");
    //         },
    //         onHide : function ($element) {
    //             $(".trHighlight").removeClass("trHighlight");
    //         }
    //     });
    // });
</script>
