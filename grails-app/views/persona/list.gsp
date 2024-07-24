<%@ page import="seguridad.Permiso; seguridad.Permiso; seguridad.Prfl; seguridad.PermisoUsuario; seguridad.Sesn; seguridad.Accs; seguridad.Persona" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Personal</title>

    <style type="text/css">
    .table {
        font-size     : 12px;
        margin-bottom : 0 !important;
    }

    .perfiles option:first-child {
        font-weight : normal !important;
    }
    </style>
</head>

<body>
<g:set var="iconActivar" value="fa-hdd-o"/>
<g:set var="iconDesactivar" value="fa-power-off"/>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px; margin-top: 10px">
    <div class="btn-group">
        <g:link action="form" class="btn btn-primary btnCrear">
            <i class="fa fa-user"></i> Nuevo Usuario
        </g:link>
    </div>
    <div class="btn-group">
        <g:link controller="tipoPersona" action="list" class="btn btn-success btnTipos">
            <i class="fa fa-users"></i> Tipos de usuarios
        </g:link>
    </div>
</div>

<g:set var="admin" value="${seguridad.Permiso.findByCodigo('P013')}"/>

<table class="table table-condensed table-bordered table-striped" width='100%'>
    <thead>
    <tr>
        <th style="width: 60px;" class="text-center">
            <div class="btn-group text-left">
                <button type="button" class="btn btn-primary btn-xs dropdown-toggle" data-toggle="dropdown">
                    <g:if test="${params.estado}">
                        <g:if test="${params.estado == 'usuario'}">
                            <i class="fa fa-user text-info"></i>
                        </g:if>
                        <g:if test="${params.estado == 'inactivo'}">
                            <i class="fa fa-user text-muted"></i>
                        </g:if>
                        <g:if test="${params.estado == 'admin'}">
                            <i class="fa fa-user text-success"></i>
                        </g:if>
                    </g:if>
                    <g:else>
                        Estado
                    </g:else>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li>
                        <a href="#" class="a" data-tipo="">
                            Todos
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#" class="a" data-tipo="inactivo">
                            <i class="fa fa-user text-muted"></i> Inactivo
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#" class="a" data-tipo="admin">
                            <i class="fa fa-user text-success"></i> Administrador
                        </a>
                    </li>
                    <li>
                        <a href="#" class="a" data-tipo="usuario">
                            <i class="fa fa-user text-info"></i> Activo
                        </a>
                    </li>
                </ul>
            </div>
        </th>
        <g:sortableColumn property="login" title="Usuario" params="${params}"/>
        <g:sortableColumn property="nombre" title="Nombre" params="${params}"/>
        <g:sortableColumn property="apellido" title="Apellido" params="${params}"/>
        <th>Consultorio</th>
        <th style="width: 220px;">
            <g:select name="perfil" from="${Prfl.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre"
                      class="form-control input-sm perfiles" noSelection="['': 'Todos los perfiles']" value="${params.perfil}"/>
        </th>
        <th>
            Acciones
        </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${personaInstanceList}" status="i" var="personaInstance">
        <g:set var="del" value="${true}"/>
        <g:if test="${Sesn.countByUsuario(personaInstance) > 0}">
            <g:set var="del" value="${false}"/>
        </g:if>
        <g:set var="perfiles" value="${Sesn.withCriteria {
            eq("usuario", personaInstance)
            or {
                le("fechaInicio", new Date())
                isNull("fechaInicio")
            }
            or {
                ge("fechaFin", new Date())
                isNull("fechaFin")
            }
            perfil {
                order("nombre")
            }
        }}"/>

        <tr data-id="${personaInstance.id}" data-tramites="0"
            class="${personaInstance.activo == 1 ? 'activo' : 'inactivo'} ${del ? 'eliminar' : ''}" id="trPersona" style="font-size: 10px">
            <td class="text-center">
                <i class="fa fa-user text-${!personaInstance.estaActivo ? 'muted' : 'info'}"></i>
            </td>
            <td><elm:textoBusqueda texto='${fieldValue(bean: personaInstance, field: "login")}' search='${params.search}'/></td>
            <td><elm:textoBusqueda texto='${fieldValue(bean: personaInstance, field: "nombre")}' search='${params.search}'/></td>
            <td><elm:textoBusqueda texto='${fieldValue(bean: personaInstance, field: "apellido")}' search='${params.search}'/></td>
            <td>${personaInstance?.empresa?.nombre}</td>
            <td style="font-size: 10px">
                <g:each in="${perfiles}" var="per" status="p">
                    ${p > 0 ? ', ' : ''}<strong>${per.perfil.nombre}</strong>
                </g:each>
            </td>
            <td style="width: 15%; text-align: center">
                <a href="#" class="btn btn-xs btn-info btnVer" data-id="${personaInstance?.id}" title="Ver">
                    <i class="fas fa-search-plus"></i>
                </a>
                <a href="#" class="btn btn-xs btn-success btnEditar" data-id="${personaInstance?.id}" title="Editar">
                    <i class="fas fa-edit"></i>
                </a>
                <a href="#" class="btn btn-xs btn-warning btnPerfiles" data-id="${personaInstance?.id}" title="Perfiles">
                    <i class="fas fa-book"></i>
                </a>
                <a href="#" class="btn btn-xs btn-danger btnEliminar" data-id="${personaInstance?.id}" title="Eliminar">
                    <i class="fas fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${personaInstanceCount}" params="${params}"/>


<script type="text/javascript">

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        createEditRow(id, "persona");
    });

    $(".btnEliminar").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    $(".btnVer").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Persona",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    });

    $(".btnPerfiles").click(function () {
        var id = $(this).data("id");
        location.href="${createLink(controller: 'persona', action: 'config')}/" + id
    });

    var tramites = 0;

    function submitForm() {
        var $form = $("#frmPersona");
        if ($form.valid()) {

            var dialog = cargarLoader("Guardando...");

            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'persona', action:'savePersona_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if (parts[0] === "ok") {
                       log(parts[1],"success");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "<strong>Eliminar</strong> usuario del sistema",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i>" +
                "<p> ¿Está seguro que desea eliminar al usuario seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar Usuario",
                    className : "btn-danger",
                    callback  : function () {
                        var d = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'persona', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                d.modal('hide');
                                closeLoader();
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1],"success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                }else{
                                    log(parts[1],"error");
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function cambiarEstadoRow(itemId, activar, tramites) {
        var icon, textMsg, textBtn, textLoader, url, clase;
        if (activar) {
            clase = "success";
            icon = "${iconActivar}";
            textMsg = "<p>¿Está seguro que desea activar la persona seleccionada?</p>";
            textBtn = "Activar";
            textLoader = "Activando";
            url = "${createLink(action:'activar_ajax')}";
            var b = bootbox.dialog({
                title   : "Alerta",
                message : "<i class='fa " + icon + " fa-3x pull-left text-" + clase + " text-shadow'></i>" + textMsg,
                buttons : {
                    cancelar      : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                        }
                    },
                    cambiarEstado : {
                        label     : "<i class='fa " + icon + "'></i> " + textBtn,
                        className : "btn-" + clase,
                        callback  : function () {
                            openLoader(textLoader);
                            $.ajax({
                                type    : "POST",
                                url     : url,
                                data    : {
                                    id : itemId
                                },
                                success : function (msg) {
                                    var parts = msg.split("_");
                                    log(parts[1], parts[0] === "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                    if (parts[0] === "OK") {
                                        location.reload();
                                    } else {
                                        closeLoader();
                                    }
                                }
                            });
                        }
                    }
                }
            });
        } else {
            clase = "danger";
            icon = "${iconDesactivar}";
            textBtn = "Desactivar";
            textLoader = "Desactivando";
            url = "${createLink(action:'desactivar_ajax')}";
        }
    }
    function createEditRow(id, tipo) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id} : {};

        var url = "";
        switch (tipo) {
            case "persona":
                url = "${createLink(controller: 'persona', action:'form_ajax')}";
                break;
            case "usuario":
                url = "${createLink(controller: 'persona',  action:'formUsuario_ajax')}";
                break;
        }

        $.ajax({
            type    : "POST",
            url     : url,
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "modal-lg",
                    title   : title + tipo,
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    %{--function createContextMenu(node) {--}%
    %{--    var $tr = $(node);--}%

    %{--    var items = {--}%
    %{--        header : {--}%
    %{--            label  : "Acciones",--}%
    %{--            header : true--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var id = $tr.data("id");--}%

    %{--    var estaActivo = $tr.hasClass("activo");--}%
    %{--    var estaInactivo = $tr.hasClass("inactivo");--}%
    %{--    var puedeEliminar = $tr.hasClass("eliminar");--}%

    %{--    puedeEliminar = true;--}%

    %{--    var ver = {--}%
    %{--        label  : 'Ver',--}%
    %{--        icon   : "fa fa-search",--}%
    %{--        action : function () {--}%
    %{--            $.ajax({--}%
    %{--                type    : "POST",--}%
    %{--                url     : "${createLink(controller: 'persona', action:'show_ajax')}",--}%
    %{--                data    : {--}%
    %{--                    id : id--}%
    %{--                },--}%
    %{--                success : function (msg) {--}%
    %{--                    bootbox.dialog({--}%
    %{--                        title   : "Ver Persona",--}%
    %{--                        message : msg,--}%
    %{--                        buttons : {--}%
    %{--                            ok : {--}%
    %{--                                label     : "Aceptar",--}%
    %{--                                className : "btn-primary",--}%
    %{--                                callback  : function () {--}%
    %{--                                }--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            });--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var editar = {--}%
    %{--        label           : 'Editar',--}%
    %{--        icon            : "fa fa-pen text-success",--}%
    %{--        separator_after : true,--}%
    %{--        action          : function (e) {--}%
    %{--            createEditRow(id, "persona");--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var config = {--}%
    %{--        label           : 'Perfiles',--}%
    %{--        icon            : "fa fa-address-card text-info",--}%
    %{--        separator_after : true,--}%
    %{--        url             : "${createLink(controller: 'persona', action: 'config')}/" + id--}%
    %{--    };--}%

    %{--    var eliminar = {--}%
    %{--        label            : 'Eliminar Usuario',--}%
    %{--        icon             : "fa fa-times-circle text-danger",--}%
    %{--        action           : function (e) {--}%
    %{--            deleteRow(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    items.ver = ver;--}%
    %{--    items.editar = editar;--}%
    %{--    if (estaActivo) {--}%
    %{--        items.config = config;--}%
    %{--    }--}%

    %{--    if (puedeEliminar) {--}%
    %{--        items.eliminar = eliminar;--}%
    %{--    }--}%

    %{--    return items;--}%
    %{--}--}%

    $(function () {

        $("#perfil").change(function () {
            openLoader();
            var params = "${params}";
            var id = $(this).val();
            var strParams = "";
            params = str_replace('[', '', params);
            params = str_replace(']', '', params);
            params = str_replace(':', '=', params);
            params = params.split(",");
            for (var i = 0; i < params.length; i++) {
                params[i] = $.trim(params[i]);
                if (params[i].startsWith("perfil")) {
                    params[i] = "perfil=" + id;
                }
                if (!params[i].startsWith("action") && !params[i].startsWith("controller") && !params[i].startsWith("format") && !params[i].startsWith("offset")) {
                    strParams += params[i] + "&"
                }
            }
            location.href = "${createLink(action: 'list')}?" + strParams
        });

        $(".a").click(function () {
            var tipo = $(this).data("tipo");
            openLoader();
            var params = "${params}";
            var strParams = "";
            params = str_replace('[', '', params);
            params = str_replace(']', '', params);
            params = str_replace(':', '=', params);
            params = params.split(",");
            for (var i = 0; i < params.length; i++) {
                params[i] = $.trim(params[i]);
                if (params[i].startsWith("estado")) {
                    params[i] = "estado=" + tipo;
                }
                if (!params[i].startsWith("action") && !params[i].startsWith("controller") && !params[i].startsWith("format") && !params[i].startsWith("offset")) {
                    strParams += params[i] + "&"
                }
            }
            location.href = "${createLink(action: 'list')}?" + strParams
        });

        $(".btnCrear").click(function () {
            createEditRow(null, "persona");
            return false;
        });

        // $("tr").contextMenu({
        //     items  : createContextMenu,
        //     onShow : function ($element) {
        //         $element.addClass("trHighlight");
        //     },
        //     onHide : function ($element) {
        //         $(".trHighlight").removeClass("trHighlight");
        //     }
        // });

    });
</script>

</body>
</html>
