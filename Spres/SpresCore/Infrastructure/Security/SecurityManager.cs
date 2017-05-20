using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Spres.Infrastructure.Security
{
    public static class SecurityManager{
        
        //CRUD Roles
        public static IEnumerable<Role> GetRoles()
        {
            using (var db = new SpresIdentityDbContext())
            {
                var roleManager = new RoleManager(new RoleStore<Role>(db));
                return roleManager.Roles.OrderBy(e => e.Name).ToList();
            }
            //return roleManager.Roles.OrderBy(e => e.Name);
                        
        }

        public static bool CreateRole(string name)
        {
            using (var db = new SpresIdentityDbContext())
            {
                
                var rolManager = new RoleManager(new RoleStore<Role>(db));
                var result = db.RoleManager.Create(new Role(name));
                return result.Succeeded;
            }
            
            //var result = roleManager.Create(new Role(name));
            //spresSecurityDbContext.SaveChanges();
            //return result.Succeeded;
        }

        public static bool UpdateRole(Role role)
        {
            using (var db = new SpresIdentityDbContext())
            {                
                var result = db.RoleManager.Update(role);
                return result.Succeeded;
            }
            
        }

        public static bool DeleteRole(string id)
        {
            using(var db =  new SpresIdentityDbContext())
            {
                //var role = GetRole(id);
                var roleId = db.RoleManager.FindById(id);
                
                var result = db.RoleManager.Delete(roleId);
                
                return result.Succeeded;
            }
            
        }

        //private static Role GetRole(string id)
        //{
        //    return roleManager.FindById(id);
        //}

        //CRUD Users
        public static IEnumerable<User> GetUsers()
        {
            using (var db = new SpresIdentityDbContext())
            {                
                var userManager = new UserManager(new UserStore<User>(db));                
                return userManager.Users.OrderBy(e => e.UserName).ToList();
            }
            
        }


        public static User GetUser(string username)
        {
            using (var db = new SpresIdentityDbContext())
            {
                var userManager = new UserManager(new UserStore<User>(db));
                return userManager.FindByName(username);
            }
        }

        public static string GetUsername(string userid)
        {
            using (var db = new SpresIdentityDbContext())
            {
                var userManager = new UserManager(new UserStore<User>(db));
                var user = userManager.FindById(userid);
                return (user == null) ? null : user.UserName;
            }
        }

        public static bool CreateUser(User user)
        {
            using (var db = new SpresIdentityDbContext())
            {
                if (string.IsNullOrEmpty(user.Id))
                {
                    user.Id = Guid.NewGuid().ToString();
                }
                //var userManager = new UserManager(new UserStore<User>(db));
                var result = db.UserManager.Create(user, user.PasswordTemp);
                return result.Succeeded;
            }
                
           
        }

        public static bool UpdateUser(User user)
        {
            using (var db = new SpresIdentityDbContext())
            {


                //var currentUser = GetUser(user.Id);
                //currentUser.UserName = user.UserName;
                //var result = userManager.Update(currentUser);
                //spresSecurityDbContext.SaveChanges();
                //var userManager = new UserManager(new UserStore<User>(db));

                var result = db.UserManager.Update(user);
                return result.Succeeded;
            }

        }

        public static bool ChangePassword(string id,string currenPassword ,string newPassword){
            using(var db =  new SpresIdentityDbContext()){

                var currentUser = db.Users.FirstOrDefault(u => u.Id.Equals(id));
                if (currentUser != null)
                {
                    currentUser.PasswordTemp = null;
                    db.SaveChanges();
                }

                var result = db.UserManager.ChangePassword(id,currenPassword, newPassword);
                return result.Succeeded;
            }
        }
        public static bool DeleteUser(string id)
        {
            using (var db = new SpresIdentityDbContext())
            {
                
                
                var userId = db.UserManager.FindById(id);
                var result = db.UserManager.Delete(userId);
                return result.Succeeded;
            }
        }

        //private static User GetUser(string id)
        //{
        //    return userManager.FindById(id);
        //}

    }
}
