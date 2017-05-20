using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class AccountsController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public async Task<IHttpActionResult> Get(int id = 0)
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    var accounts = await dbContext.Accounts.ToListAsync();
                    if (id == 0)
                    {
                        var childAccounts =  accounts.Where(ca => ca.Parent != null).ToList();

                        var result = accounts.Where(a => a.Parent == null).OrderBy(a => a.Code).Select(a => new Account
                        {
                            Id = a.Id,
                            Code = a.Code,
                            Name = a.Name,
                            ParentId = a.ParentId,
                            Children = GetChildren(childAccounts, a.Id),
                            Packages = a.Packages.ToList().Select(p => new Package { Id = p.Id, Name = p.Name }).ToList(),
                            Type = a.Type
                        });
                        return Ok(result.ToDataResult());
                    }
                    else if (id == -1)
                    {
                        return Ok(accounts.OrderBy(a => a.Code).Select(a => new Account
                        {
                            Id = a.Id,
                            Code = a.Code,
                            Name = a.Name,
                            ParentId = a.ParentId,
                            Packages = a.Packages.ToList().Select(p => new Package { Id = p.Id, Name = p.Name }).ToList(),
                            Type = a.Type
                        }).ToDataResult());
                    }
                    else 
                    {
                        var parent = accounts.FirstOrDefault(c => c.Id == id);                        
                        return Ok(parent.Children.OrderBy(c => c.Code).ToList().Select(a => new Account
                        {
                            Id = a.Id,
                            Code = a.Code,
                            Name = a.Name,
                            ParentId = a.ParentId,
                            Children = GetChildren(a.Children.ToList(), a.Id),
                            Packages = a.Packages.ToList().Select(p => new Package { Id = p.Id, Name = p.Name }).ToList(),
                            Type = a.Type
                        }).ToDataResult());
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }            
        }
        
        private static List<Account> GetChildren(List<Account> accounts, int parentId)
        {
            return accounts.Where(a => a.Parent.Id == parentId).Select(a => new Account
            {
                Id = a.Id,
                Name = a.Name,
                Code = a.Code,
                ParentId = parentId,
                Children = GetChildren(accounts, a.Id),
                Packages = a.Packages.ToList().Select(p => new Package { Id = p.Id, Name = p.Name }).ToList(),
                Type = a.Type
            }).ToList();
        }

        [Route("api/Accounts/GetParentAccounts")]
        public IHttpActionResult GetParentAccounts()
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    var accounts = dbContext.Accounts.Where(a=> a.ParentId == null).ToList();

                    var result = new List<TreeViewModel>();

                    result.Add(new TreeViewModel()
                    {
                        HasChild = true,
                        Id = 9999999,
                        Name = "Todos",
                        ParentId = null
                    });

                    result.AddRange(accounts.Select(a => new TreeViewModel()
                    {
                        Id = a.Id,
                        Name = a.Code + " " + a.Name,
                        ParentId = 9999999,
                        HasChild = true
                    }).ToList());

                    return Ok(result);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }
    }

   

}
