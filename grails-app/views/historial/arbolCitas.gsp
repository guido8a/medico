
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">

    <title>Citas del paciente</title>

    <asset:javascript src="/jstree-3.0.8/dist/jstree.min.js"/>
    <asset:stylesheet src="/jstree-3.0.8/dist/themes/default/style.min.css"/>

    <style type="text/css">
    #tree {
        overflow-y : auto;
        height     : 440px;
    }

    .jstree-search {
        color : #5F87B2 !important;
    }
    </style>

</head>

<body>

<div id="cargando" class="text-center">
    <p>Cargando...</p>

    <img src="${resource(dir: 'images', file: 'spinner.gif')}" alt='Cargando...' width="64px" height="64px"/>

    <p>Por favor espere</p>
</div>

<div class="row" style="margin-bottom: 10px;">

    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-info" id="btnRegresar" title="Volver a paciente">
                    <i class="fa fa-arrow-left"></i> Regresar
                </a>
            </div>
            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-success" id="btnIrPaciente" title="Volver a paciente">
                    <i class="fa fa-user"></i> Ir a Paciente
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-2">
        <div class="input-group input-group-sm">
            <g:textField name="searchArbol" class="form-control input-sm" placeholder="Buscador"/>
            <span class="input-group-btn">
                <a href="#" id="btnSearchArbol" class="btn btn-sm btn-info">
                    <i class="fa fa-search"></i>&nbsp;
                </a>
            </span>
        </div><!-- /input-group -->
    </div>

    <div class="col-md-3 hidden" id="divSearchRes">
        <span id="spanSearchRes">
            5 resultados
        </span>

        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnNextSearch" title="Siguiente">
                <i class="fa fa-chevron-down"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnPrevSearch" title="Anterior">
                <i class="fa fa-chevron-up"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnClearSearch" title="Limpiar búsqueda">
                <i class="fa fa-times-circle"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-1">
        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnCollapseAll" title="Cerrar todos los nodos">
                <i class="fa fa-minus-square"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnExpandAll" title="Abrir todos los nodos">
                <i class="fa fa-plus-square"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-4 text-right pull-right" style="font-size: 18px">
        <i class="fa fa-parking text-success"></i> Diagnóstico
        <i class="fa fa-copyright text-primary"></i> Cita
    </div>
</div>

<div id="tree" class="well hidden">

</div>

<script type="text/javascript">

    $("#btnRegresar").click(function () {
        location.href="${createLink(controller: 'paciente', action: 'datos')}?id=" + "${paciente?.id}"
    });

    $("#btnIrPaciente").click(function () {
        location.href="${createLink(controller: 'paciente', action: 'datos')}?id=" + "${paciente?.id}"
    });

    var searchRes = [];
    var posSearchShow = 0;
    var $treeContainer = $("#tree");

    %{--function createEditProvincia(id) {--}%
    %{--    var title = id ? "Editar" : "Crear";--}%
    %{--    var data = id ? {id : id} : {};--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'provincia', action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id    : "dlgCreateEdit",--}%
    %{--                title : title + " Provincia",--}%
    %{--                // class : "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormProvincia();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--            setTimeout(function () {--}%
    %{--                b.find(".form-control").first().focus()--}%
    %{--            }, 500);--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%

    %{--function createEditCanton(id, parentId) {--}%

    %{--    var title = id ? "Editar" : "Crear";--}%
    %{--    var data = id ? {id : id} : {};--}%
    %{--    if (parentId) {--}%
    %{--        data.padre = parentId;--}%
    %{--    }--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'canton', action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id    : "dlgCreateEditC",--}%
    %{--                title : title + " Cantón",--}%
    %{--                class : "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormCanton();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--            setTimeout(function () {--}%
    %{--                b.find(".form-control").first().focus()--}%
    %{--            }, 500);--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%

    %{--function createEditParroquia(id, parentId) {--}%

    %{--    var title = id ? "Editar" : "Crear";--}%
    %{--    var data = id ? {id : id} : {};--}%
    %{--    if (parentId) {--}%
    %{--        data.padre = parentId;--}%
    %{--    }--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'parroquia', action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id    : "dlgCreateEditP",--}%
    %{--                title : title + " Parroquia",--}%
    %{--                class : "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormParroquia();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--            setTimeout(function () {--}%
    %{--                b.find(".form-control").first().focus()--}%
    %{--            }, 500);--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%


    %{--function createEditComunidad(id, parentId) {--}%

    %{--    var title = id ? "Editar" : "Crear";--}%
    %{--    var data = id ? {id : id} : {};--}%
    %{--    if (parentId) {--}%
    %{--        data.padre = parentId;--}%
    %{--    }--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'comunidad', action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id    : "dlgCreateEditCo",--}%
    %{--                title : title + " Comunidad",--}%
    %{--                class : "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormComunidad();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--            setTimeout(function () {--}%
    %{--                b.find(".form-control").first().focus()--}%
    %{--            }, 500);--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%

    %{--function submitFormProvincia() {--}%
    %{--    var $form = $("#frmSave-provinciaInstance");--}%
    %{--    var $btn = $("#dlgCreateEdit").find("#btnSave");--}%
    %{--    if ($form.valid()) {--}%
    %{--        var data = $form.serialize();--}%
    %{--        $btn.replaceWith(spinner);--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : $form.attr("action"),--}%
    %{--            data    : data,--}%
    %{--            success : function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parts = msg.split("_");--}%
    %{--                if(parts[0] == 'ok'){--}%
    %{--                    log(parts[1], "success");--}%
    %{--                    setTimeout(function () {--}%
    %{--                        location.reload(true);--}%
    %{--                    }, 1000);--}%
    %{--                }else{--}%
    %{--                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                    return false;--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%

    %{--function submitFormCanton() {--}%
    %{--    var $form = $("#frmSave-cantonInstance");--}%
    %{--    var $btn = $("#dlgCreateEditC").find("#btnSave");--}%
    %{--    if ($form.valid()) {--}%
    %{--        $("#provincia").attr("disabled", false)--}%
    %{--        var data = $form.serialize();--}%
    %{--        $btn.replaceWith(spinner);--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : $form.attr("action"),--}%
    %{--            data    : data,--}%
    %{--            success : function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parts = msg.split("_");--}%
    %{--                if(parts[0] == 'ok'){--}%
    %{--                    log(parts[1], "success");--}%
    %{--                    setTimeout(function () {--}%
    %{--                        location.reload(true);--}%
    %{--                    }, 1000);--}%
    %{--                }else{--}%
    %{--                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                    return false;--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%

    %{--function submitFormParroquia() {--}%
    %{--    var $form = $("#frmSave-parroquiaInstance");--}%
    %{--    var $btn = $("#dlgCreateEditP").find("#btnSave");--}%
    %{--    if ($form.valid()) {--}%
    %{--        $("#canton").attr("disabled", false)--}%
    %{--        var data = $form.serialize();--}%
    %{--        $btn.replaceWith(spinner);--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : $form.attr("action"),--}%
    %{--            data    : data,--}%
    %{--            success : function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parts = msg.split("_");--}%
    %{--                if(parts[0] == 'ok'){--}%
    %{--                    log(parts[1], "success");--}%
    %{--                    setTimeout(function () {--}%
    %{--                        location.reload(true);--}%
    %{--                    }, 1000);--}%
    %{--                }else{--}%
    %{--                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                    return false;--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%

    %{--function submitFormComunidad() {--}%
    %{--    var $form = $("#frmSave-comunidadInstance");--}%
    %{--    var $btn = $("#dlgCreateEditCo").find("#btnSave");--}%
    %{--    if ($form.valid()) {--}%
    %{--        $("#parroquia").attr("disabled", false);--}%
    %{--        var data = $form.serialize();--}%
    %{--        $btn.replaceWith(spinner);--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : $form.attr("action"),--}%
    %{--            data    : data,--}%
    %{--            success : function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parts = msg.split("_");--}%
    %{--                if(parts[0] == 'ok'){--}%
    %{--                    log(parts[1], "success");--}%
    %{--                    setTimeout(function () {--}%
    %{--                        location.reload(true);--}%
    %{--                    }, 1000);--}%
    %{--                }else{--}%
    %{--                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                    return false;--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%



    function createContextMenu(node) {
        $(".lzm-dropdown-menu").hide();

        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;

        // var nodeParentId = $node.parent().parent().children()[1].id.split("_")[1]
        // console.log("n " + nodeParentId)
        // var nodeText = $node.children("a").first().text();

        var esRoot = nodeType === "root";
        var esPrincipal = nodeType === "principal";
        var esCanton = nodeType.contains("canton");
        var esParroquia = nodeType.contains("parroquia");
        var esComunidad = nodeType.contains("comunidad");

        var items = {};

        // var agregarProvincia = {
        //     label  : "Agregar Provincia",
        //     icon   : "fa fa-parking text-success",
        //     action : function () {
        //         // createEditProvincia(null);
        //     }
        // };
        //
        // var agregarCanton = {
        //     label  : "Agregar Cantón",
        //     icon   : "fa fa-copyright text-info",
        //     action : function () {
        //         // createEditCanton(null, nodeId);
        //     }
        // };
        //
        // var agregarCanton2 = {
        //     label  : "Agregar Cantón",
        //     icon   : "fa fa-copyright text-info",
        //     action : function () {
        //         // createEditCanton(null, $node.parent().parent().children()[1].id.split("_")[1]);
        //     }
        // };
        //
        // var agregarParroquia = {
        //     label  : "Agregar Parroquia",
        //     icon   : "fa fa-registered text-danger",
        //     action : function () {
        //         // createEditParroquia(null, nodeId);
        //     }
        // };
        //
        // var agregarParroquia2 = {
        //     label  : "Agregar Parroquia",
        //     icon   : "fa fa-registered text-danger",
        //     action : function () {
        //         // createEditParroquia(null, $node.parent().parent().children()[1].id.split("_")[1]);
        //     }
        // };
        //
        // var agregarComunidad = {
        //     label  : "Agregar Comunidad",
        //     icon   : "fa fa-info-circle text-warning",
        //     action : function () {
        //         // createEditComunidad(null, nodeId);
        //     }
        // };
        //
        // var agregarComunidad2 = {
        //     label  : "Agregar Comunidad",
        //     icon   : "fa fa-info-circle text-warning",
        //     action : function () {
        //         // createEditComunidad(null, $node.parent().parent().children()[1].id.split("_")[1]);
        //     }
        // };
        //
        // var editarProvincia = {
        //     label  : "Editar Provincia",
        //     icon   : "fa fa-pen text-info",
        //     action : function () {
        //         // createEditProvincia(nodeId);
        //     }
        // };
        //
        // var editarCanton = {
        //     label  : "Editar Cantón",
        //     icon   : "fa fa-pen text-info",
        //     action : function () {
        //         // createEditCanton(nodeId, null);
        //     }
        // };
        //
        // var editarParroquia = {
        //     label  : "Editar Parroquia",
        //     icon   : "fa fa-pen text-info",
        //     action : function () {
        //         // createEditParroquia(nodeId, null);
        //     }
        // };

        %{--var editarComunidad = {--}%
        %{--    label  : "Editar Comunidad",--}%
        %{--    icon   : "fa fa-pen text-info",--}%
        %{--    action : function () {--}%
        %{--        // createEditComunidad(nodeId, null);--}%
        %{--    }--}%
        %{--};--}%

        %{--var verProvincia = {--}%
        %{--    label            : "Ver datos de la provincia",--}%
        %{--    icon             : "fa fa-laptop text-info",--}%
        %{--    separator_before : true,--}%
        %{--    action           : function () {--}%
        %{--        $.ajax({--}%
        %{--            type    : "POST",--}%
        %{--            url     : "${createLink(controller: "provincia", action:'show_ajax')}",--}%
        %{--            data    : {--}%
        %{--                id : nodeId--}%
        %{--            },--}%
        %{--            success : function (msg) {--}%
        %{--                bootbox.dialog({--}%
        %{--                    title   : "Ver Provincia",--}%
        %{--                    message : msg,--}%
        %{--                    buttons : {--}%
        %{--                        ok : {--}%
        %{--                            label     : "Aceptar",--}%
        %{--                            className : "btn-primary",--}%
        %{--                            callback  : function () {--}%
        %{--                            }--}%
        %{--                        }--}%
        %{--                    }--}%
        %{--                });--}%
        %{--            }--}%
        %{--        });--}%
        %{--    }--}%
        %{--};--}%

        var verCanton = {
            label            : "Datos de la cita",
            icon             : "fa fa-laptop text-info",
            separator_before : true,
            action           : function () {
                    location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' +  "&id=" + nodeId
            }
        };

        if (esRoot) {
            // items.agregarProvincia = agregarProvincia;
        } else if (esPrincipal) {
            // items.agregarProvincia = agregarProvincia;
            // items.agregarCanton = agregarCanton;
            // items.verProvincia = verProvincia;
            // items.editarProvincia = editarProvincia;
            // items.borrarProvincia = borrarProvincia;
        } else if (esCanton) {
            items.verCanton = verCanton;
        }
        return items;
    }

    function scrollToNode($scrollTo) {
        $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
            scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
        });
    }

    function scrollToRoot() {
        var $scrollTo = $("#root");
        scrollToNode($scrollTo);
    }

    function scrollToSearchRes() {
        var $scrollTo = $(searchRes[posSearchShow]).parents("li").first();
        $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
        scrollToNode($scrollTo);
    }

    $(function () {

        $treeContainer.on("loaded.jstree", function () {
            $("#cargando").hide();
            $("#tree").removeClass("hidden");
        }).on("select_node.jstree", function (node, selected, event) {
        }).jstree({
            plugins     : ["types", "state", "contextmenu", "search"],
            core        : {
                multiple       : false,
                check_callback : true,
                themes         : {
                    variant : "small",
                    dots    : true,
                    stripes : true
                },
                data           : {
                    url   : '${createLink(controller: 'historial' , action:"loadTreePart_ajax")}',
                    data  : function (node) {
                        return {
                            id    : node.id,
                            paciente: '${paciente?.id}',
                            sort  : "${params.sort?:'nombre'}",
                            order : "${params.order?:'asc'}"
                        };
                    }
                }
            },
            contextmenu : {
                show_at_node : false,
                items        : createContextMenu
            },
            state       : {
                key : "unidades",
                opened: false
            },
            search      : {
                fuzzy             : false,
                show_only_matches : false,
                ajax              : {
                    url     : "${createLink(controller: 'canton', action:'arbolSearch_ajax')}",
                    success : function (msg) {
                        var json = $.parseJSON(msg);
                        $.each(json, function (i, obj) {
                            $('#tree').jstree("open_node", obj);
                        });
                        setTimeout(function () {
                            searchRes = $(".jstree-search");
                            var cantRes = searchRes.length;
                            posSearchShow = 0;
                            $("#divSearchRes").removeClass("hidden");
                            $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                            scrollToSearchRes();
                        }, 300);

                    }
                }
            },
            types       : {
                root                : {
                    icon : "fa fa-sitemap text-info"
                },
                yachay              : {
                    icon : "fa fa-building text-info"
                },
                unidadPadreActivo   : {
                    icon : "fa fa-building-o text-info"
                },
                unidadPadreInactivo : {
                    icon : "fa fa-building-o text-muted"
                },
                unidadHijoActivo    : {
                    icon : "fa fa-home text-success"
                },
                unidadHijoInactivo  : {
                    icon : "fa fa-home text-muted"
                },
                usuarioActivo       : {
                    icon : "fa fa-user text-info"
                },
                usuarioInactivo     : {
                    icon : "fa fa-user text-muted"
                }
            }
        });

        $("#btnExpandAll").click(function () {
            $treeContainer.jstree("open_all");
            scrollToRoot();
            return false;
        });

        $("#btnCollapseAll").click(function () {
            $treeContainer.jstree("close_all");
            scrollToRoot();
            return false;
        });

        $('#btnSearchArbol').click(function () {
            $treeContainer.jstree("open_all");
            $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
            return false;
        });
        $("#searchArbol").keypress(function (ev) {
            if (ev.keyCode === 13) {
                $treeContainer.jstree("open_all");
                $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                return false;
            }
        });

        $("#btnPrevSearch").click(function () {
            if (posSearchShow > 0) {
                posSearchShow--;
            } else {
                posSearchShow = searchRes.length - 1;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnNextSearch").click(function () {
            if (posSearchShow < searchRes.length - 1) {
                posSearchShow++;
            } else {
                posSearchShow = 0;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnClearSearch").click(function () {
            $treeContainer.jstree("clear_search");
            $("#searchArbol").val("");
            posSearchShow = 0;
            searchRes = [];
            scrollToRoot();
            $("#divSearchRes").addClass("hidden");
            $("#spanSearchRes").text("");
        });

    });
</script>

</body>
</html>