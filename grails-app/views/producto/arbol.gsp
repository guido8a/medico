<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Artículos de Inventario</title>

%{--    <script type="text/javascript" src="${resource(dir: 'js/plugins/jstree', file: 'jstree.js')}"></script>--}%
%{--    <link rel="stylesheet" href="${resource(dir: 'js/plugins/jstree/themes/default', file: 'style.css')}"/>--}%
%{--    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'tree_context.css')}"/>--}%

    <asset:javascript src="/jstree-3.0.8/dist/jstree.min.js"/>
    <asset:stylesheet src="/jstree-3.0.8/dist/themes/default/style.min.css"/>

    <style type="text/css">
    #tree {
        background: #DEDEDE;
        overflow-y: auto;
        width: 50%;
        height: 700px;
        float: left;
        border: solid 2px #6AA8BA;
    }

    #info {
        background: #E4E4DC;
        float: left;
        margin-left: 5px;
        width: 49%;
        height: 700px;
        border: solid 2px #5A98AA;
    }

    </style>

</head>

<body>
<div id="list-cuenta" style="margin-top: 20px">

%{--        <div class="span12 btn-group" data-toggle="buttons-radio">--}%
%{--            <a href='#' class='btn btn-warning' id="btnCerrar" onclick="$('#tree').jstree('close_all');"><i class='fa fa-times'></i> Cerrar todo</a>--}%

%{--            <form class="form-search" style="float: left; margin-left: 50px;">--}%
%{--                <div class="input-append">--}%
%{--                    <input  title="Buscar"  type="text" class="input-medium search-query" id="search"/>--}%
%{--                    <a href='#' class='btn btn-info' id="btnSearch"><i class='fa fa-search'></i> Buscar</a>--}%
%{--                </div>--}%
%{--            </form>--}%
%{--        </div>--}%

        <div id="treeArea" class="hide">
            <div id="tree" class="ui-corner-all"></div>
        </div>
</div>

<script type="text/javascript">

    function submitForm() {
        var $form = $("#frmGrupo");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
             var c = cargarLoader("Guardando...");
            $.ajax({
                type: "POST",
                url: $form.attr("action"),
                data: $form.serialize(),
                success: function (msg) {
                   c.modal("hide");
                    var parts = msg.split("_");
                    if (parts[0] === "ok") {
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload()
                        }, 800);
                    } else {
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function createEditRow(id, nodo, padre, url, tipo) {
        var data = tipo === "Crear" ? { 'padre': id, 'nodo': nodo, 'empresa' : '${empresa?.id}'} : {'id': id, 'nodo': nodo, 'padre': padre, 'empresa' : '${empresa?.id}'};

        $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
                    title: tipo + " " +  nodo,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    var $input = b.find(".form-control").not(".datepicker").first();
                    var val = $input.val();
                    $input.focus();
                    $input.val("");
                    $input.val(val);
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function createContextMenu(node) {
        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var tipo = nodeStrId.split("_")[0];
        var nodeId = nodeStrId.split("_")[1];

        var padre = node.parent;
        var padreId = padre.split("_")[1];

        var nodeHasChildren = $node.hasClass("hasChildren");

        var url = "";
        var nodo = "";
        var urlHijo = "";
        var nodoHijo = "";

        switch (tipo) {
            case "root":
                urlHijo = "${createLink(action:'formGrupo_ajax')}";
                nodo = "root";
                nodoHijo = "Grupo";
                break;
            case "gp":
                url = "${createLink(action:'formGrupo_ajax')}";
                urlHijo = "${createLink(action:'formSubgrupo_ajax')}";
                nodo = "Grupo";
                nodoHijo = "Subgrupo";
                break;
            case "sg":
                url = "${createLink(action:'formSubgrupo_ajax')}";
                urlHijo = "${createLink(action:'formProducto_ajax')}";
                nodo = "Subgrupo";
                nodoHijo = "Producto";
                break;
            case "dp":
                url = "${createLink(action:'formProducto_ajax')}";
                nodo = "Producto";
                break;
        }

        var crearHijo = {
            label: "Nuevo " + nodoHijo,
            icon: "fa fa-plus-circle text-success",
            action: function (obj) {
                // createEditRow(nodeId, nodo, padreId, urlHijo, "Hijo");
                createEditRow(nodeId, nodoHijo, padreId, urlHijo, "Crear");
            }
        };

        var editar = {
            label: "Editar " + nodo,
            icon: "fa fa-edit text-info",
            action: function (obj) {
                createEditRow(nodeId, nodo, padreId, url, "Editar");
            }
        };

        var items = {
        };

        var crear = {
            label: "Nuevo " + nodo,
            icon: "fa fa-plus-circle text-success",
            action: function (obj) {
                createEditRow(nodeId, nodo, padreId, url, "Crear");
            }
        };

        var duplicar = {
            label: "Duplicar artículo",
            icon: "fa fa-plus-circle text-warning",
            action: function (obj) {
                bootbox.dialog({
                    title: "Alerta",
                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-info text-shadow'></i><p>¿Está seguro que desea duplicar este artículo?.</p>",
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        eliminar: {
                            label: "<i class='fa fa-check'></i> Aceptar",
                            className: "btn-success",
                            callback: function () {
                                $.ajax({
                                    type: "POST",
                                    url: '${createLink(action:'duplicar_ajax')}',
                                    data: {
                                        id: nodeId
                                    },
                                    success: function (msg) {
                                        closeLoader();
                                        var parts = msg.split("_");
                                        if(parts[0] === 'ok'){
                                            log("Item duplicado correctamente", "success");
                                            setTimeout(function () {
                                                location.reload()
                                            }, 800);
                                        }else{
                                            log("Error al duplicar el item", "error");
                                        }
                                    }
                                });
                            }
                        }
                    }
                });
            }
        };

        if(nodo === 'root') {
            // items.crear = crear
            items.crearHijo = crearHijo;
        }

        if(nodo === 'Grupo' || nodo === 'Subgrupo'){
            items.crearHijo = crearHijo;
            items.editar = editar;
        }

        if(nodo === 'Producto'){
            items.editar = editar;
        }

        if (!nodeHasChildren) {

            var urlProducto = '${createLink(controller: 'producto', action: 'borrarProducto_ajax')}';
            var urlSubgrupo = '${createLink(controller: 'producto', action: 'borrarSubgrupo_ajax')}';
            var urlGrupo = '${createLink(controller: 'producto', action: 'borrarGrupo_ajax')}';

            var urlBorrado = nodo === 'Grupo' ? urlGrupo : (nodo === 'Subgrupo' ? urlSubgrupo : urlProducto );

            items.eliminar = {
                label: "Eliminar " + nodo,
                separator_before: true,
                icon: "fa fa-trash text-danger",
                action: function (obj) {
                    bootbox.dialog({
                        title: "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Borrar",
                        message: "<p>¿Está seguro que desea borrar este " + nodo + "? Esta acción no se puede deshacer.</p>",
                        buttons: {
                            cancelar: {
                                label: "Cancelar",
                                className: "btn-primary",
                                callback: function () {
                                }
                            },
                            eliminar: {
                                label: "<i class='fa fa-trash'></i> Borrar",
                                className: "btn-danger",
                                callback: function () {
                                    var a = cargarLoader("Borrando...");
                                    $.ajax({
                                        type: "POST",
                                        url: urlBorrado,
                                        data: {
                                            id: nodeId
                                        },
                                        success: function (msg) {
                                            a.modal("hide");
                                            if (msg === "ok") {
                                                log("Borrado correctamente", "success");
                                                setTimeout(function () {
                                                    location.reload()
                                                }, 800);
                                            } else {
                                                log("Error al borrar", "error");
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            };
        }

        return items;
    }

    $(function () {

        function doSearch() {
            var val = $.trim($("#search").val());
            if (val !== "") {
                $('#tree').jstree('search', val);
            }
        }

        $("#btnSearch").click(function () {
            doSearch();
        });

        var current = "1";

        $(".btnCopiar").click(function () {
            openLoader("Copiando");
        });

        function iniciaNodo() {
            var rel = "grupo_" + current;
            return rel;
        }

        function poneTipo(tipo) {
            var grpo = tipo.split('_')[0];
            var tp;
            switch (grpo) {
                case "sg":
                    tp = "subgrupo";
                    break;
                case "dp":
                    tp = "producto";
                    break;
            }
            return tp;
        }

        $(".toggle").click(function () {
            var tipo = $(this).attr("id").split('_')[1];
            if (tipo !== current) {
                current = tipo;
                $('#tree').jstree(true).refresh();
            }
        });

        $('#tree').on("loaded.jstree", function () {
            $("#loading").hide();
            $("#treeArea").removeClass("hide").show();
        }).on("select_node.jstree", function (node, selected, event) {
            $('#tree').jstree('toggle_node', selected.selected[0]);
            // showInfo(selected.node.id);
        }).jstree({
            plugins: ["types", "state", "contextmenu", "wholerow", "search"],
            core: {
                multiple: false,
                check_callback: true,
                themes: {
                    variant: "small"
                },
                data: {
                    url: '${createLink(action:"loadTreePart")}',
                    data: function (node) {
                        var tp;
                        if ((node.id !== "#") && (node.id !== 'root')) {
                            tp = poneTipo(node.id);
                        } else {
                            tp = iniciaNodo()
                        }
                        return {'id': node.id, tipo: tp};
                    }
                }
            },
            contextmenu: {
                show_at_node: false,
                items: createContextMenu
            },
            state: {
                key: "cuentas"
            },
            types: {
                root: {
                    // icon: "glyphicon glyphicon-folder-open text-danger"
                    icon: "fa fa-sitemap text-info"
                },
                "grupo": {
                    icon: "glyphicon glyphicon-briefcase text-warning"
                },
                "subgrupo_material": {
                    icon: "glyphicon glyphicon-briefcase text-info"
                },
                default: {
                    icon: "glyphicon glyphicon-tags text-success"
                }
            },
            search : {
                case_insensitive : true,
                show_only_matches : false
            }
        });

        function showInfo(nodoId) {
            var parts = nodoId.split("_");
            var tipo = parts[0];
            var id = parts[1];

            if(tipo !== 'root'){
                switch (tipo) {
                    case "sg":
                        url = "${createLink(action:'showSg_ajax')}";
                        break;
                    case "dp":
                        url = "${createLink(action:'showDp_ajax')}";
                        break;
                    case "it":
                        url = "${createLink(action:'showIt_ajax')}";
                        break;
                }
                $.ajax({
                    type: "POST",
                    url: url,
                    data: {
                        id: id
                    },
                    success: function (msg) {
                        $("#info").html(msg);
                    }
                });
            }
        }
    });
</script>

</body>
</html>
