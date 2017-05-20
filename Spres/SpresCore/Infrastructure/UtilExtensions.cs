using System;

namespace Spres.Infrastructure
{
    public static class UtilExtensions
    {
        public static bool ToBoolean(this string value)
        {
            switch (value.ToLower())
            {
                case "true":
                    return true;
                case "false":
                    return false;   
                default:
                    throw new InvalidCastException("You can not cast a weird value to a bool");
            }
        }
    }
}
