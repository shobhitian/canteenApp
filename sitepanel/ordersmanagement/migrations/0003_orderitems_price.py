# Generated by Django 3.2.17 on 2023-08-08 07:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ordersmanagement', '0002_alter_transaction_table'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderitems',
            name='price',
            field=models.IntegerField(default='30'),
            preserve_default=False,
        ),
    ]
