﻿using FSK.Repository.Base;
using FSK.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace FSK.Repository.Repository
{
    public class StatusRepository : GenericRepository<Status>
    {

        public StatusRepository(SWP391FengShuiKoiSystemContext context) => _context = context;

        
    }
}
