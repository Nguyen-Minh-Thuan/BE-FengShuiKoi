using FSK.Repository.Base;
using FSK.Repository.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSK.Repository.Repository
{
    public class BlogRepository : GenericRepository<Blog>
    {

        public BlogRepository(SWP391FengShuiKoiSystemContext context) => _context = context;

    }
}
