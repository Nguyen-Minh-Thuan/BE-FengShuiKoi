﻿using FSK.Repository.Base;
using FSK.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
<<<<<<< HEAD
using Microsoft.EntityFrameworkCore;
=======
>>>>>>> main

namespace FSK.Repository.Repository
{
    public class StatusRepository : GenericRepository<Status>
    {

        public StatusRepository(SWP391FengShuiKoiSystemContext context) => _context = context;

<<<<<<< HEAD
        
=======
>>>>>>> main
    }
}
