
$(function () {

    $("#editSucess").hide();
    $("#editFail").hide();
    $("#addSucess").hide();
    $("#addFail").hide();
    $("#deleteSucess").hide();
    $("#deleteFail").hide();

    $('#addButton').on("click", function () {
        var url = "/property";

        var param = {};
        param.addKey = $("#addKey").val();
        param.addValue = $("#addValue").val();
        param.addDesc = $("#addDesc").val();
        param.envs = getEnvs();

        $.ajax(url, {
            data: jQuery.toJSON(param),
            dataType: "json",
            contentType: "application/json",
            method: "post",
            success: function (added) {
                if (added) {
                    $("#addSucess").html("保存成功");
                    $('#addSucess').show().delay(2000).hide(0);
                } else {
                    $("#addFail").html("保存失败");
                    $('#addFail').show().delay(2000).hide(0);
                }
            }
        });
    });

    $('#editButton').on("click", function () {
        var url = "/property";

        var param = {};
        param.editKey = $("#editKey").val();
        param.editValue = $("#editValue").val();
        param.editDesc = $("#editDesc").val();
        param.env = currentEnv;

        $.ajax(url, {
            data: jQuery.toJSON(param),
            dataType: "json",
            contentType: "application/json",
            method: "put",
            success: function (updated) {
                if (updated) {
                    $("#editSucess").html("更新成功");
                    $('#editSucess').show().delay(2000).hide(0);
                    Window.location.reload();
                } else {
                    $("#editFail").html("更新失败");
                    $('#editFail').show().delay(2000).hide(0);
                }
            }
        });
    });

    $('#deleteButton').on("click", function () {
        var url = "/property";

        var param = {};
        param.deleteKey = $("#deleteKey").val();
        param.env = currentEnv;

        $.ajax(url, {
            data: jQuery.toJSON(param),
            dataType: "json",
            contentType: "application/json",
            method: "delete",
            success: function (deleted) {
                if (deleted) {
                    $("#deleteSucess").html("删除成功");
                    $('#deleteSucess').show().delay(2000).hide(0);
                    Window.location.reload();
                } else {
                    $("#deleteFail").html("删除失败");
                    $('#deleteFail').show().delay(2000).hide(0);
                }
            }
        });
    });

    $("[name='tabEnv']").on("click", function () {
        var href = this.getAttribute("href");
        var index = href.lastIndexOf("/") + 1;
        currentEnv = href.sub(index);
    });

});

function editProperty(index) {
    var key = $("#v_key" + index).html();
    var value = $("#v_value" + index).html();
    var desc = $("#v_desc" + index).html();
    $("#editKey").val(key);
    $("#editValue").val(value);
    $("#editDesc").val(desc);
}
;

function deleteProperty(index) {
    var key = $("#v_key" + index).html();
    var value = $("#v_value" + index).html();
    var desc = $("#v_desc" + index).html();
    $("#deleteKey").val(key);
    $("#deleteValue").val(value);
    $("#deleteDesc").val(desc);
}
;

function getEnvs() {
    var envs = "";
    $('input[name="addEnv"]:checked').each(function () {
        envs = envs + $(this).val() + ",";
    });

    envs = envs.substr(0, envs.lastIndexOf(","));
    return envs;
}
