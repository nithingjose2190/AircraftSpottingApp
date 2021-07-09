using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AircraftSpottingApp
{
    public class SpottingLog_DTO
    {
        public int Id { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public string Registration { get; set; }
        public string RegistrationSuffix { get; set; }
        public string RegistrationPrefix { get; set; }
        public string Location { get; set; }
        public System.DateTime SpottedWhen { get; set; }
        public string Image { get; set; }
    }
}