<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>项目配置页</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container-fluid" style="margin-top:20px;" class="col-sm-12">
<div class="modal-header">
    <h3 class="modal-title">${project}项目详情</h3>
</div>
<div class="panel-heading">
    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
        添加
    </button>
</div>
<div class="modal-body">
<ul class="nav nav-tabs">
<#list allEnvs as env>
    <li role="presentation" <#if selectedEnv = env>class="active" </#if>><a name="tabEnv"
                                                                            href="/list/${project}/${env}">${env}</a>
    </li>
</#list>
</ul>
<table class="table table-striped">
    <thead>
    <tr>
        <th width="20%">KEY</th>
        <th width="30%">DESC</th>
        <th width="20%">VALUE</th>
        <th width="10%">编辑</th>
        <th width="10%">删除</th>
    </tr>
    </thead>
    <tbody>
    <#list properties?keys as key>
    <tr>
        <td id="v_key${key_index}">${key}</td>
        <td id="v_desc${key_index}">${properties[key].desc}</td>
        <td id="v_value${key_index}">${properties[key].value}</td>
        <td><a href="javascript:void(0)" id="edit${key_index}" onclick="editProperty(${key_index})" data-toggle="modal"
               data-target="#editModal">编辑</a></td>
        <td><a href="javascript:void(0)" id="delete${key_index}" onclick="deleteProperty(${key_index})"
               data-toggle="modal"
               data-target="#deleteModal">删除</a></td>
    </tr>
    </#list>
    </tbody>
</table>

<!-- addModal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">创建配置项</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="key" class="col-sm-2 control-label">KEY:</label>

                        <div class="col-sm-10">
                            <input type="text" id="addKey" class="form-control" id="desc" placeholder=""
                                   required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">DESC:</label>

                        <div class="col-sm-10">
                            <textarea id="addDesc" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="check" class="col-sm-2 control-label">ENVS:</label>

                        <div class="col-sm-10">
                            <div class="checkbox">
                            <#list allEnvs as env>
                                <label>
                                    <input type="checkbox" name="addEnv" value="${env}">${env}
                                </label>
                            </#list>
                            </div>
                        </div>
                    </div>
                    <div class="form-group stringValue">
                        <label for="desc" class="col-sm-2 control-label">VALUE:</label>

                        <div class="col-sm-10">
                            <textarea id="addValue" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group booleanValue hide">
                        <label for="desc" class="col-sm-2 control-label">VALUE:</label>

                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                                True
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                False
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div class="alert alert-success" role="alert" id="addSucess"></div>
                <div class="alert alert-danger" role="alert" id="addFail"></div>
                <button type="button" class="btn btn-primary" id="addButton">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- editModal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑配置项</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">KEY:</label>

                        <div class="col-sm-10">
                            <input class="form-control" id="editKey" disabled/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">VALUE:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" id="editValue" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">DESC:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" id="editDesc" rows="3"></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <div class="alert alert-success" role="alert" id="editSucess"></div>
                <div class="alert alert-danger" role="alert" id="editFail"></div>
                <button type="button" class="btn btn-primary" id="editButton">更新</button>
                <button type="button" class="btn btn-default" id="closeEditButton" data-dismiss="modal">关闭
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">你确定要删除以下配置项吗？</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">KEY:</label>

                        <div class="col-sm-10">
                            <input class="form-control" id="deleteKey" disabled/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">VALUE:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" id="deleteValue" rows="3" disabled></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label">DESC:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" id="deleteDesc" rows="3" disabled></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <div class="alert alert-success" role="alert" id="deleteSucess"></div>
                <div class="alert alert-danger" role="alert" id="deleteFail"></div>
                <button type="button" class="btn btn-primary" id="deleteButton">确认删除</button>
                <button type="button" class="btn btn-default" id="closeDeleteButton" data-dismiss="modal">关闭
                </button>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<script src="/js/jquery.js"></script>
<script src="/js/jquery.json.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript">

    var currentEnv = "${selectedEnv}";

    $(function () {

        $("#editSucess").hide();
        $("#editFail").hide();
        $("#addSucess").hide();
        $("#addFail").hide();
        $("#deleteSucess").hide();
        $("#deleteFail").hide();

        $('#addButton').on("click", function () {
            var url = "/add";

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
            var url = "/update";

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
            var url = "/delete";

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

</script>
</body>

</html>
