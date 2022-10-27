# Generated by Django 4.1.2 on 2022-10-23 21:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("problems", "0019_auto_20221022_1604"),
    ]

    operations = [
        migrations.AlterModelOptions(
            name="historicalpart",
            options={
                "get_latest_by": ("history_date", "history_id"),
                "ordering": ("-history_date", "-history_id"),
                "verbose_name": "historical part",
                "verbose_name_plural": "historical parts",
            },
        ),
        migrations.AlterModelOptions(
            name="historicalproblem",
            options={
                "get_latest_by": ("history_date", "history_id"),
                "ordering": ("-history_date", "-history_id"),
                "verbose_name": "historical problem",
                "verbose_name_plural": "historical problems",
            },
        ),
        migrations.AlterField(
            model_name="historicalpart",
            name="history_date",
            field=models.DateTimeField(db_index=True),
        ),
        migrations.AlterField(
            model_name="historicalproblem",
            name="history_date",
            field=models.DateTimeField(db_index=True),
        ),
    ]
