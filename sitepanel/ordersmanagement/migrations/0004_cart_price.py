# Generated by Django 3.2.17 on 2023-08-08 07:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ordersmanagement', '0003_orderitems_price'),
    ]

    operations = [
        migrations.AddField(
            model_name='cart',
            name='price',
            field=models.IntegerField(default='20'),
            preserve_default=False,
        ),
    ]
