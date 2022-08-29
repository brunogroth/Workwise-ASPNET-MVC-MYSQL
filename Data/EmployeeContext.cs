using CSharp_EmployeeCrud.Models;
using Microsoft.EntityFrameworkCore;

namespace CSharp_EmployeeCrud.Data
{
    public class EmployeeContext : DbContext{
        public EmployeeContext(DbContextOptions options) : base(options)
        {
            
        }
        public DbSet<Employee> Employees { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder){

            //Defining max length
            modelBuilder.Entity<Employee>()
                .Property(p => p.Name)
                    .HasMaxLength(80);
            
            modelBuilder.Entity<Employee>()
                .Property(p => p.City)
                    .HasMaxLength(80);
                
            //Incluing predefined values for to be inserted at creation of database
            modelBuilder.Entity<Employee>()
                .HasData(
                    new Employee { Id = 1, Name = "John Galt", City = "New York"}
                );
        }
    }
}