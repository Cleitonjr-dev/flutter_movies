import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/movie.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Poster ─────────────────────────────────────
          Center(
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              child: Image(
                image: NetworkImage(movie.image),
                height: 295,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 210,
                  height: 295,
                  color: cs.surfaceContainerHighest,
                  child: Icon(Icons.broken_image,
                      size: 64, color: cs.onSurfaceVariant),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Rating e Status ────────────────────────────
          Row(
            children: [
              if (movie.rating != null) ...[
                const Icon(Icons.star, color: Colors.amber, size: 22),
                const SizedBox(width: 4),
                Text(
                  movie.rating!.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              _StatusChip(status: movie.status),
            ],
          ),
          const SizedBox(height: 16),

          // ── Gêneros ────────────────────────────────────
          if (movie.genres.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: movie.genres
                  .map((g) => Chip(
                        label: Text(g),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: cs.secondaryContainer,
                        labelStyle:
                            TextStyle(color: cs.onSecondaryContainer),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],

          // ── Sinopse ────────────────────────────────────
          if (movie.summary.isNotEmpty) ...[
            Text('Sinopse',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                )),
            const SizedBox(height: 8),
            Text(
              movie.summary,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Metadados ──────────────────────────────────
          _InfoSection(cs: cs, children: [
            if (movie.premiered != null)
              _InfoRow(icon: Icons.calendar_today, label: 'Estreia', value: movie.premiered!),
            if (movie.network != null)
              _InfoRow(icon: Icons.tv, label: 'Emissora', value: movie.network!),
            if (movie.language != null)
              _InfoRow(icon: Icons.language, label: 'Idioma', value: movie.language!),
            if (movie.runtime != null)
              _InfoRow(icon: Icons.timer, label: 'Duracao', value: '${movie.runtime} min'),
            _InfoRow(icon: Icons.link, label: 'Site oficial', value: movie.link, isLink: true),
          ]),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = status == 'Ended'
        ? Colors.red.shade400
        : status == 'Running'
            ? Colors.green.shade400
            : cs.outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status == 'Ended'
            ? 'Finalizada'
            : status == 'Running'
                ? 'Em exibicao'
                : status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.cs, required this.children});

  final ColorScheme cs;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLink = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: isLink
                  ? () async {
                      final uri = Uri.parse(value);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    }
                  : null,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isLink ? cs.primary : cs.onSurface,
                  decoration: isLink ? TextDecoration.underline : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
