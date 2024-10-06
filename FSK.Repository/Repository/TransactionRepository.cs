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
    public class TransactionRepository : GenericRepository<Transaction>
    {

        public TransactionRepository(SWP391FengShuiKoiSystemContext context) => _context = context;

        public async Task<Transaction> FirstOrDefaultAsync(Expression<Func<Transaction, bool>> predicate)
        {
            return await _context.Set<Transaction>().FirstOrDefaultAsync(predicate);
        }
    }
}
