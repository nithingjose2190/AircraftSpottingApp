/// <reference path="jquery-2.0.3.min.js" />
/// <reference path="knockout-3.0.0.js" />
/// <reference path="moment.js" />
/// <reference path="moment-with-locales.js" />
/// <reference path="moment-with-locales.min.js" />
/// <reference path="moment.min.js" />

function SpottingLog(data) {
    this.Id = ko.observable(data.Id);
    this.Make = ko.observable(data.Make);
    this.Model = ko.observable(data.Model);
    this.Registration = ko.observable(data.Registration);
    this.RegistrationPrefix = ko.observable(data.RegistrationPrefix);
    this.RegistrationSuffix = ko.observable(data.RegistrationSuffix);
    this.Location = ko.observable(data.Location);
    this.SpottedWhen = ko.observable(moment(data.SpottedWhen).format('DD/MM/YYYY hh:mma'));
}



function SpottingLogViewModel() {
    var self = this;
    self.SpottingLog_DTO = ko.observableArray([]);
    self.Id = ko.observable();
    self.Make = ko.observable();
    self.Model = ko.observable();
    self.RegistrationPrefix = ko.observable();
    self.Registration = ko.observable();
    self.RegistrationSuffix = ko.observable();
    self.Location = ko.observable();
    self.SpottedWhen = ko.observable();
    self.searchText = ko.observable();


    self.AddSpottingLog = function () {
        if (self.Make() == null ||
            self.Model() == null ||
            self.RegistrationPrefix() == null ||
            self.RegistrationSuffix() == null ||
            self.Location() == null ||
            self.SpottedWhen() == null) {
            alert("Please enter all fields");
            return;
        }

        var enteredDate = new Date(self.SpottedWhen()).getTime() / 1000;
        var now = new Date();
        if (enteredDate >= now.getTime()/1000) {
            alert("Spotted date time should be a value in the past");
            return;
        }


        var regist = self.RegistrationPrefix().concat('-', self.RegistrationSuffix()).toString();
        self.SpottingLog_DTO.push(new SpottingLog({
            Make: self.Make(),
            Model: self.Model(),
            Registration: regist,
            RegistrationPrefix: self.RegistrationPrefix(),
            RegistrationSuffix: self.RegistrationSuffix(),
            Location: self.Location(),
            SpottedWhen: self.SpottedWhen()
        }));
        
        self.Id(""),
        self.Make(""),
        self.Model(""),
        self.RegistrationPrefix(""),
        self.RegistrationSuffix(""),
        self.Registration(""),
        self.Location(""),
        self.SpottedWhen("")

        $.ajax({
            type: "POST",
            url: 'SpotAircraft.aspx/SaveSpottingLog',
            data: ko.toJSON({ data: self.SpottingLog_DTO }),
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                alert(result.d);
            },
            error: function (err) {
                alert(err.status + " - " + err.statusText);
            }
        });
    };

    self.DeleteSpottingLog = function (SpottingLog_DTO) {

        $.ajax({
            type: "POST",
            url: 'SpotAircraft.aspx/DeleteSpottingLog',
            data: ko.toJSON({ data: SpottingLog_DTO }),
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                alert(result.d);
                self.SpottingLog_DTO.remove(SpottingLog_DTO)
            },
            error: function (err) {
                alert(err.status + " - " + err.statusText);
            }
        });

    };

    self.UpdateSpottingLog = function (SpottingLog_DTO) {

        $.ajax({
            type: "POST",
            url: 'SpotAircraft.aspx/UpdateSpottingLog',
            data: ko.toJSON({ data: SpottingLog_DTO }),
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                alert(result.d);
                self.SpottingLog_DTO.push(SpottingLog)
            },
            error: function (err) {
                alert(err.status + " - " + err.statusText);
            }
        });
    };


    $.ajax({
        type: "POST",
        url: 'SpotAircraft.aspx/FetchSpottingLogs',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(results) {
            var spottingLogs = $.map(results.d,
                function(item) {
                    return new SpottingLog(item);
                });
            self.SpottingLog_DTO(spottingLogs);
        },
        error: function(err) {
            alert(err.status + " - " + err.statusText);
        }
    });


}

$(document).ready(function() {
    // Use Javascript
    var today = new Date();
    
    document.getElementById("dateandtime").max = moment().format("YYYY-MM-DD[T]HH:mm:ss");

    ko.bindingHandlers.dataTablesForEach = {
        page: 0,
        init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
            var binding = ko.utils.unwrapObservable(valueAccessor());

            ko.unwrap(binding.data);

            if (binding.options.paging) {
                binding.data.subscribe(function (changes) {
                    var table = $(element).closest('table').DataTable();
                    ko.bindingHandlers.dataTablesForEach.page = table.page();
                    table.destroy();
                }, null, 'arrayChange');
            }

            var nodes = Array.prototype.slice.call(element.childNodes, 0);
            ko.utils.arrayForEach(nodes, function (node) {
                if (node && node.nodeType !== 1) {
                    node.parentNode.removeChild(node);
                }
            });

            return ko.bindingHandlers.foreach.init(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext);
        },
        update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
            var binding = ko.utils.unwrapObservable(valueAccessor()),
                key = 'DataTablesForEach_Initialized';

            ko.unwrap(binding.data);

            var table;
            if (!binding.options.paging) {
                table = $(element).closest('table').DataTable();
                table.destroy();
            }

            ko.bindingHandlers.foreach.update(element, valueAccessor, allBindings, viewModel, bindingContext);

            table = $(element).closest('table').DataTable(binding.options);

            if (binding.options.paging) {
                if (table.page.info().pages - ko.bindingHandlers.dataTablesForEach.page === 0) {
                    table.page(--ko.bindingHandlers.dataTablesForEach.page).draw(false);
                } else {
                    table.page(ko.bindingHandlers.dataTablesForEach.page).draw(false);
                }
            }

            if (!ko.utils.domData.get(element, key) && (binding.data || binding.length)) {
                ko.utils.domData.set(element, key, true);
            }

            return {
                controlsDescendantBindings: true
            };
        }
    };
  
        ko.applyBindings(new SpottingLogViewModel());
   
       
	
    
});
