using FSK.Repository.Base;
using FSK.Repository.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace FSK.Repository.Repository
{
    public class UserRepository : GenericRepository<User>
    {

        public UserRepository(SWP391FengShuiKoiSystemContext context) => _context = context;

        public async Task<User> FirstOrDefaultAsync(Expression<Func<User, bool>> predicate)
        {
            return await _context.Set<User>().FirstOrDefaultAsync(predicate);
        }


    }
}
