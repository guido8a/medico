<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Agenda</title>

    <style type="text/css">
    .gestion > td {
        background-color: #ff8080;
        color: #0c0460;
    }

    .normal > td {
        background-color: #d7dff9;
        color: #0c3440;
    }
    .usado {
        text-align: center !important;
        background-image: repeating-linear-gradient(#618acf, #c1faf8, #618acf)
    }
    .conjunta {
        text-align: center !important;
        color: #404040;
        border-top-left-radius: 20px;
        border-bottom-right-radius: 20px;
    }
    .otro {
        text-align: center !important;
        background-color: #d7bec8;
    }
    .libre {
        color: #606060;
    }
    .horas {
        text-align: center !important;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
        color: #0070B0;
        margin-top: 15px;
        text-align: center;
    }
    </style>

</head>

<body>


<div class="col-md-12">
    <h3 class="titl" style="margin-top: 5px">Agenda del médico</h3>
</div>

<div class="btn-toolbar toolbar" style="margin-top: 10px">

    <div class="col-md-3">
        <label for="semana" class="col-md-1 control-label" style="text-align: right">
            Semana
        </label>
        <g:select name="semana" from="${medico.Semana.list([sort: "numero" ])}"
                  class="form-control input-sm " optionValue="${{it?.fechaInicio?.format("dd-MM-yyyy")  + " - " +  it?.fechaFin?.format("dd-MM-yyyy") }}" optionKey="id"
        />
    </div>

    <div class="col-md-3">
        <label for="doctor" class="col-md-1 control-label" style="text-align: right">
            Doctor
        </label>
        <g:select name="doctor" from="${seguridad.Persona.list([sort: 'apellido'])}"
                  class="form-control input-sm " optionValue="${{it.apellido + " " + it.nombre}}" optionKey="id"
        />
    </div>

    <div class="col-md-2">
        <div class="btn-group" role="navigation" style="margin-top: 20px">
            <a href="#" class="btn btn-success btnNuevoPaciente">
                <i class="fa fa-user"></i>
                Nuevo Paciente
            </a>
        </div>
    </div>

</div>

<div id="divTabla">

</div>



<script type="text/javascript">
    var id = null;

    $(".btnNuevoPaciente").click(function () {
        location.href="${createLink(controller: 'paciente', action: 'datos')}?tipo=" + 1
    });

    cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());

    // function submitForm() {
    //     var $form = $("#frmAsignatura");
    //     var $btn = $("#dlgCreateEdit").find("#btnSave");
    //     $.ajax({
    //         type: "POST",
    //         url: $form.attr("action"),
    //         data: $form.serialize(),
    //         success: function (msg) {
    //             if (msg === 'ok') {
    //                 log("Asignatura guardada correctamente", "success");
    //                 setTimeout(function () {
    //                     location.reload(true);
    //                 }, 1000);
    //             } else {
    //                 log("Error al guardar la hora", "error")
    //             }
    //         }
    //     });
    // }

    %{--function deleteRow(itemId) {--}%
    %{--    bootbox.dialog({--}%
    %{--        title: "Alerta",--}%
    %{--        message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +--}%
    %{--            "¿Está seguro que desea eliminar el paralelo seleccionado? Esta acción no se puede deshacer.</p>",--}%
    %{--        closeButton: false,--}%
    %{--        buttons: {--}%
    %{--            cancelar: {--}%
    %{--                label: "Cancelar",--}%
    %{--                className: "btn-primary",--}%
    %{--                callback: function () {--}%
    %{--                }--}%
    %{--            },--}%
    %{--            eliminar: {--}%
    %{--                label: "<i class='fa fa-trash'></i> Eliminar",--}%
    %{--                className: "btn-danger",--}%
    %{--                callback: function () {--}%
    %{--                    $.ajax({--}%
    %{--                        type: "POST",--}%
    %{--                        url: '${createLink(controller: 'programa', action:'delete_ajax')}',--}%
    %{--                        data: {--}%
    %{--                            id: itemId--}%
    %{--                        },--}%
    %{--                        success: function (msg) {--}%
    %{--                            if (msg === 'ok') {--}%
    %{--                                setTimeout(function () {--}%
    %{--                                    location.reload();--}%
    %{--                                }, 300);--}%
    %{--                            } else {--}%
    %{--                                log("Error al borrar la hora", "error")--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            }--}%
    %{--        }--}%
    %{--    });--}%
    %{--}--}%

    function borraHora(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar la hora seleccionada? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'programa', action:'borra_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                if (msg === 'ok') {
                                    setTimeout(function () {
                                        cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());
                                    }, 300);
                                } else {
                                    log("Error al borrar la hora", "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function creaHora(dia, hora) {
        var parl = $("#paralelo").val();
        var asig = $("#asignatura").val();

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'programa', action:'creaHora')}",
            data: {},
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Crear la Hora de clases",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-default",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-trash'></i> Asignar hora",
                            className: "btn-info",
                            callback: function () {
                                $.ajax({
                                    type: "POST",
                                    url: '${createLink(controller: 'programa', action:'crea_ajax')}',
                                    data: {
                                        asig: asig,
                                        parl: parl,
                                        dia: dia,
                                        hora: hora
                                    },
                                    success: function (msg) {
                                        console.log('retiorna:', msg);
                                        if (msg === 'ok') {
                                            setTimeout(function () {
                                                cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());
                                            }, 300);
                                            log("Horario creado exitosamente", "success")
                                        } else {
                                            log("Error al borrar la hora", "error")
                                        }
                                    }
                                });
                            }
                        }
                    }
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        });
        //location.reload()//ajax
    } //cre


    %{--function createEditRow(id) {--}%
    %{--    var title = id ? "Editar" : "Crear";--}%
    %{--    var asig = $("#asignatura").val();--}%

    %{--    $.ajax({--}%
    %{--        type: "POST",--}%
    %{--        url: "${createLink(controller: 'programa', action:'creaParalelo')}",--}%
    %{--        data: {id: id,--}%
    %{--            asig: asig},--}%
    %{--        success: function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                title: title + " Paralelo",--}%
    %{--                closeButton: false,--}%
    %{--                message: msg,--}%
    %{--                class: "modal-lg"--}%
    %{--            }); //dialog--}%
    %{--            setTimeout(function () {--}%
    %{--                b.find(".form-control").first().focus()--}%
    %{--            }, 500);--}%
    %{--        } //success--}%
    %{--    });--}%
    %{--    //location.reload()//ajax--}%
    %{--}--}%


    function cargaTabla(semana, doctor) {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'agenda', action:'tabla_ajax')}",
            data: {semana: semana,
                doctor: doctor
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            } //success
        });
        //location.reload()//ajax
    }// /createEdit

    $("#semana").change(function () {
        var semana = $(this).val();
        var doctor = $("#doctor option:selected").val();
        cargaTabla(semana, doctor);
    });

    $("#doctor").change(function () {
        var doctor = $(this).val();
        var semana = $("#semana option:selected").val();
        cargaTabla(semana, doctor);
    });

    %{--function activaBotonEditar(asignatura, paralelo){--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url: "${createLink(action:'verificarProfesor_ajax')}",--}%
    %{--        async: false,--}%
    %{--        data    : {--}%
    %{--            asignatura: asignatura,--}%
    %{--            paralelo: paralelo--}%
    %{--        },--}%
    %{--        success : function (msg) {--}%
    %{--            if(msg === 'true'){--}%
    %{--                $("#btnEditarCurso").removeClass("hide")--}%
    %{--            }else{--}%
    %{--                $("#btnEditarCurso").addClass("hide")--}%
    %{--            }--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--}--}%

    $("#btnParalelo").click(function () {
        createEditRow();
        return false;
    });

    $("#btnProgramar").click(function () {
        paralelo();
        return false;
    });

    $("#btnCrear").click(function () {
        createEditRow();
        return false;
    });

    $("#btnEditar").click(function () {
        var id = $("#paralelo").val();
        createEditRow(id);
        return false;
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $("#btnBorrar").click(function () {
        var id = $("#paralelo").val();
        deleteRow(id);
    });

</script>

</body>
</html>
