
from django.contrib import admin
from .models import Product

class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'category', 'price', 'status', 'stock', 'availability', 'ref_user')
    list_filter = ('category', 'status', 'stock', 'availability', 'ref_user')
    search_fields = ('name', 'description')
    # Other configurations or customizations can be added here.

# Register the admin class with the Product model
admin.site.register(Product, ProductAdmin)
