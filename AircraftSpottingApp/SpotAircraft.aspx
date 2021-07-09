<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpotAircraft.aspx.cs" Inherits="AircraftSpottingApp.SpotAircraft" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>Aircraft Spotting</title>
    <script src="Scripts/jquery-2.0.3.min.js"></script>
    <script src="Scripts/knockout-3.0.0.js"></script>
    <script src="Scripts/SpotAircraft.js"></script>
    <script src="Scripts/moment.js"></script>
    <script src="Scripts/moment-with-locales.js"></script>
    <script src="Scripts/moment-with-locales.min.js"></script>
    <script src="Scripts/moment.min.js"></script>
    <script src="//cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="Styles/toastr-master/toastr.js"></script>
    <script src="Scripts/commonscript.js"></script>
    <script src="Scripts/bootstrap.bundle.js"></script>
    <script class="include" type="text/javascript" src="Scripts/jquery.dcjqaccordion.2.7.js"></script>
    <script src="Scripts/jquery.nicescroll.js"></script>
    <script src="Scripts/jquery.scrollTo.min.js"></script>
    <script src="Scripts/respond.min.js"></script>

    <link href="Styles/Style.css" rel="stylesheet" />
    <link href="Styles/mainstyle.css" rel="stylesheet" />
    <link href="Styles/style-responsive.css" rel="stylesheet" />
    <link href="//cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="Styles/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="Styles/toastr-master/build/toastr.min.css" rel="stylesheet" />
    <!-- Bootstrap core CSS -->
    <link href="Styles/data-tables/DT_bootstrap.css" rel="stylesheet" />
    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="Styles/bootstrap-reset.css" rel="stylesheet" />
</head>
<body>
    <section id="container" class="">
        <!--header start-->
        <header class="header white-bg">

            <!--logo start-->
            <a href="#" class="logo">Aircraft <span>Spotting Logger</span></a>
            <!--logo end-->
            <div class="nav notify-row" id="top_menu">
                <!--  notification start -->
                <!--  notification end -->
            </div>

        </header>
        <!--header end-->
        <!--sidebar start-->
        <!--sidebar end-->
        <!--main content start-->


        <section id="main-content">
            <section class="wrapper site-min-height">
                <section class="card">
                    <div class="row">
                        <div class="col-lg-4" style="padding-right: 2px;">
                            <section class="card">
                                <header class="card-header">
                                    Add Logs
                                </header>
                                <div class="card-body">
                                    <form id="form1" runat="server">
                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-3 col-sm-3 control-label">Make</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" data-bind="value: Make"  />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-3 col-sm-3 control-label">Model</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" data-bind="value: Model" />
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-3 col-sm-3 control-label">Registration</label>
                                            <div class="col-lg-9">
                                                <div class="input-group">
                                                    <input  maxlength = 2 class="form-control rounded dpd1" data-bind="value: RegistrationPrefix"  />
                                                    <span class="px-3 py-2">-</span>
                                                    <input  maxlength = 5 class="form-control rounded dpd2" data-bind="value: RegistrationSuffix"  />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-3 col-sm-3 control-label">Location</label>
                                            <div class="col-lg-9">
                                                <input class="form-control" data-bind="value: Location" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-4 col-sm-4 control-label">Spotted When</label>
                                            <div class="col-lg-6 col-md-9 col-sm-12">
                                                <input class="form-control" id="dateandtime" type="datetime-local" data-bind="value: SpottedWhen" />                                                
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail1" class="col-lg-3 col-sm-3 control-label"></label>
                                            <div class="col-lg-6 col-md-9 col-sm-12">
                                                <button type="button" data-bind="click: AddSpottingLog" class="btn btn-primary">Add Log</button>
                                            </div>
                                        </div>
                                    </form>

                                </div>
                            </section>
                        </div>
                        <div class="col-lg-8" style="padding-left: 3px; padding: 5px">
                            <section class="card">
                                <header class="card-header">
                                    Spotting Logs
                                </header>
                                <div class="card-body">
                                    <form>
                                        <table id="myTable" class="table table-striped table-bordered" style="width: 100%;" data-bind="visible: SpottingLog_DTO().length > 0" border="0">
                                            <thead>
                                                <tr>
                                                    <th>Make</th>
                                                    <th>Model</th>
                                                    <th>Registration</th>
                                                    <th>Location</th>
                                                    <th>Spotted When</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody data-bind="dataTablesForEach: {data: SpottingLog_DTO,
			                                                                        options: { 
				                                                                        deferRender: true,
				                                                                        paging: true,
				                                                                        scrollX: true
			                                                                        }
		                                                                        }">
                                                <tr>
                                                    <td>
                                                        <input data-bind="value: Make" />
                                                    </td>
                                                    <td>
                                                        <input data-bind="value: Model" />
                                                    </td>
                                                    <td>
                                                        <input data-bind="value: Registration"  maxlength="8"/>
                                                    </td>
                                                    <td>
                                                        <input data-bind="value: Location" />
                                                    </td>
                                                    <td>
                                                        <input data-bind="value: SpottedWhen" />
                                                    </td>

                                                    <td>
                                                        <a href="#" data-bind="click: $root.UpdateSpottingLog">Update</a>
                                                        <a href="#" data-bind="click: $root.DeleteSpottingLog">Delete</a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </section>

                        </div>
                    </div>
                </section>
            </section>
        </section>
        <!-- Right Slidebar start -->
        <!-- Right Slidebar end -->
        <!--footer start-->
        <footer class="site-footer">
        </footer>
        <!--footer end-->
    </section>
</body>
</html>

