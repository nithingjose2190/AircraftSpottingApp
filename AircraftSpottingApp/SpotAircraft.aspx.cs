using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;

namespace AircraftSpottingApp
{
    public partial class SpotAircraft : System.Web.UI.Page
    {
        /// <summary>
        /// Page Load Method
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Public Web Methods.
        /// <summary>
        /// Gets Spotting Log Details
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static List<SpottingLog> FetchSpottingLogs()
        {
            SpottingLogModelEntities dbEntities = new SpottingLogModelEntities();
            var data = (from item in dbEntities.SpottingLogs
                        orderby item.Id
                        select item).Take(5);            
            var logs = data.ToList();

            return logs;
        }

        /// <summary>
        /// Saves Spotting Log Details
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod]
        public static string SaveSpottingLog(SpottingLog_DTO[] data)
        {
            try
            {
                var dbContext = new SpottingLogModelEntities();
                var logs = from log in dbContext.SpottingLogs select log;
                foreach (SpottingLog_DTO logDetails in data)
                {
                    var spottingLog = new SpottingLog();
                    if (logDetails != null)
                    {
                        spottingLog.Id = logDetails.Id;
                        spottingLog.Make = logDetails.Make;
                        spottingLog.Model = logDetails.Model;
                        spottingLog.Registration = logDetails.RegistrationPrefix + "-"+ logDetails.RegistrationSuffix;
                        spottingLog.Location = logDetails.Location;
                        spottingLog.SpottedWhen = logDetails.SpottedWhen;
                    }
                    SpottingLog sl =(from sp in logs where sp.Id== spottingLog.Id select sp).FirstOrDefault();
                    if (sl == null)
                        dbContext.SpottingLogs.Add(spottingLog);
                    dbContext.SaveChanges();
                }
                return "Data saved to database!";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        /// <summary>
        /// Deletes Spotting Log Details
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod]
        public static string DeleteSpottingLog(SpottingLog_DTO data)
        {
            try
            {
                var dbContext = new SpottingLogModelEntities();
                var spottingLog = dbContext.SpottingLogs.FirstOrDefault(logId => logId.Id == data.Id);
                if (spottingLog != null)
                {
                    dbContext.SpottingLogs.Remove(spottingLog);
                    dbContext.SaveChanges();
                }
                return "Data deleted from database!";

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        /// <summary>
        /// Updates Spotting Log Details
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod]
        public static string UpdateSpottingLog(SpottingLog_DTO data)
        {
            try
            {
                var dbContext = new SpottingLogModelEntities();
                var spottingLog = dbContext.SpottingLogs.FirstOrDefault(log => log.Id == data.Id);
                if (spottingLog  != null)
                {
                    spottingLog.Make = data.Make;
                    spottingLog.Model = data.Model;
                    spottingLog.Registration = data.Registration;
                    spottingLog.Location = data.Location;
                    spottingLog.SpottedWhen = data.SpottedWhen;
                    dbContext.SaveChanges();
                }
                return "Data saved to database!";

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        #endregion
    }
}