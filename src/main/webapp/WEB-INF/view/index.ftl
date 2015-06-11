<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>项目列表</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container-fluid" style="margin-top:20px;" class="col-sm-12">
    <div class="modal-header">
        <h3 class="modal-title">项目列表</h3>
    </div>
    <div class="modal-body">
        <table class="table table-striped">
            <thead>
            <tr>
                <th width="10%">序号</th>
                <th width="30%">业务团队</th>
                <th width="25%">业务分支</th>
                <th width="35%">项目名</th>
            </tr>
            </thead>
            <tbody>

            <#list projects as project>
            <tr>
                <td>${project_index + 1}</td>
                <td>乐牙网</td>
                <td>运营后台</td>
                <td><a href="/list/${project}">${project}</a></td>
            </tr>
            </#list>

            </tbody>
        </table>
    </div>
</div>
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
</script>
</body >
</html >
